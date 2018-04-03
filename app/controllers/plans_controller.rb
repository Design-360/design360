class PlansController < ApplicationController
  before_action :set_plan, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:[:subscription_checkout,:cancel_subscription,:invoices]
  skip_before_action  :verify_authenticity_token,only: [:webhook_payment_succeeded,:webhook_payment_failure]
  # after_action :redirect_func,only: [:webhook_payment_succeeded,:webhook_payment_failure]

  require 'stripe'
  
  def subscription_checkout
    plan_id = params[:stripe_plan_id]
    @plan = Plan.all.select{|p| p.stripe_response["id"] == plan_id }.first
    plan = Stripe::Plan.retrieve(plan_id)
    #This should be created on signup.
    if @signed_in_user.stripe_response.present?
      customer = Stripe::Customer.retrieve(@signed_in_user.stripe_response["id"])
    else
    
      customer = Stripe::Customer.create(
              :description => "Customer for #{@signed_in_user.email}",
              :source => params[:stripeToken],
              :email => params[:stripeEmail]
            )
      @signed_in_user.update(stripe_response: customer)
    end
    
    # Save this in your DB and associate with the user;s email
    stripe_subscription = customer.subscriptions.create(:plan => plan.id)
    PlanSubscriber.first_or_create(plan_id: @plan.id, user_id: @signed_in_user.id).update!(stripe_response: stripe_subscription)
    
    # @signed_in_user.subscribe!
    # redirect_to clients_dashboard_path,notice: "You have successfully subscribed to Design360 #{@plan.name} Plan"
  end
  
  def cancel_subscription
    stripe_sub_id = @signed_in_user.plan_subscriber.stripe_response["id"]
    Stripe::Subscription.retrieve(stripe_sub_id).delete
    @signed_in_user.plan_subscriber.update(stripe_response: Stripe::Subscription.retrieve(stripe_sub_id))
    @signed_in_user.cancelled!
    @signed_in_user.delete_stripe_customer
    redirect_to clients_dashboard_path, notice: "Subscription cancelled"
  end
  
  def invoices
    if @signed_in_user.stripe_response.present?
      @invoices = @signed_in_user.invoice
    end
  end
  
  def show_invoice
    @invoice = Stripe::Invoice.retrieve(id: params[:stripe_invoice_id])
    respond_to do |format|
      format.js
    end
  end
  
  def webhook_payment_succeeded
    # byebug
    @signed_in_user = User.select{ |user| user.stripe_response and user.stripe_response["id"] == params[:data][:object][:customer] }.first
    @signed_in_user.subscribe!

  end
  def redirect_func
     redirect_to clients_dashboard_path,notice: "You have successfully subscribed to Design360 #{@signed_in_user.plan.name} Plan"
  end
  
  def webhook_payment_failure
    @signed_in_user = User.select{ |user| user.stripe_response and user.stripe_response["id"] == params[:data][:object][:customer] }.first
    @signed_in_user.cancelled!
  end

  # GET /plans
  # GET /plans.json
  def index
    @plans = Plan.all
  end

  # GET /plans/1
  # GET /plans/1.json
  def show
  end

  # GET /plans/new
  def new
    @plan = Plan.new
  end

  # GET /plans/1/edit
  def edit
  end

  # POST /plans
  # POST /plans.json
  def create
    @plan = Plan.new(plan_params)
    # byebug
    plan_params[:trial_period]  = nil if plan_params[:trial_period]==""
    subscription = Stripe::Plan.create(
      :product => {
        :name => 'Basic Product',
      },
      :amount => (plan_params[:amount].to_i)*100,
      :interval => plan_params[:interval],
      :nickname => plan_params[:name],
      :currency => 'usd',
      # :trial_period_days => plan_params[:trial_period],
      :id => SecureRandom.uuid # This ensures that the plan is unique in stripe
    )
    @plan.stripe_response = subscription

    respond_to do |format|
      if @plan.save
        format.html { redirect_to @plan, notice: 'Plan was successfully created.' }
        format.json { render :show, status: :created, location: @plan }
      else
        format.html { render :new }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /plans/1
  # PATCH/PUT /plans/1.json
  def update
    respond_to do |format|
      if @plan.update(plan_params)
        format.html { redirect_to @plan, notice: 'Plan was successfully updated.' }
        format.json { render :show, status: :ok, location: @plan }
      else
        format.html { render :edit }
        format.json { render json: @plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plans/1
  # DELETE /plans/1.json
  def destroy
    @plan.destroy
    respond_to do |format|
      format.html { redirect_to plans_url, notice: 'Plan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_plan
      @plan = Plan.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def plan_params
      params.require(:plan).permit(:amount, :name, :interval,:trial_period)
    end
end
