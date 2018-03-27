require 'sidekiq/web'
Rails.application.routes.draw do
  resources :plans
  mount Sidekiq::Web => '/sidekiq'
  devise_for :employees
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  mount ActionCable.server => '/cable'
  resources :employees, :except => [:index]
  get '/assign/employees', to: "employees#listing"
  resources :templates, :except => [:show, :index]
  resources :userhome, :except => [:new, :create, :edit, :update, :show, :destroy]
  resources :orders, :except => [:index]
  resources :attachments, :only => [:create]
  get '/admin/orders', to: 'home#admin_orders'
  get '/admin/managers', to: 'home#admin_managers'
  get '/admin/templates', to: 'home#admin_templates'
  get '/admin/clients', to: 'home#admin_clients'
  get '/managers/dashboard', to: 'home#manager_dashboard'
  get '/clients/dashboard', to: 'home#client_dashboard'
  get '/admin/dashboard', to: 'home#admin_dashboard'
  root 'home#index'
  get '/terms', to: 'home#terms'
  get '/privacy_policy', to: 'home#privacy_policy'
  get '/notifications', to: 'home#notifications'
  post 'subscription_checkout' => 'plans#subscription_checkout'
  get 'invoices' => 'plans#invoices'
  put 'cancel_subscription' => 'plans#cancel_subscription'
  get 'show_invoice' => 'plans#show_invoice'
  
  post 'stripe_payment_succeeded' => 'plans#webhook_payment_succeeded'
  # scope '/admin' do
    resources :chats, except: [:edit,:new]
    resources :messages
  # end
  match "*path", to: "home#error", via: :all
end
