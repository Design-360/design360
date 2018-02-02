class TemplatesController < ApplicationController
    before_action :set_template, only: [ :edit, :update, :destroy]
    def new
        @template = Template.new
    end
    
    def create
        @template = Template.new(template_params)
        if @template.save
            redirect_to dashboard_path, notice: 'Template was successfully created.'
        else
            redirect_to dashboard_path, alert: 'error'
        end
    end
    
    def edit
    end
    
    def update
        @template = Template.update(template_params)
        redirect_to dashboard_path, notice: 'Template was successfully updated.'
    end
    
    def destroy
        @template.destroy
        toastr.info('Are you the 6 fingered man?')
        redirect_to dashboard_path, notice: 'Template was successfully destroyed.'
    end
    
    private
    
    def set_template
        @template = Template.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def template_params
        params.require(:template).permit(:name, :image)
    end
end
