Rails.application.routes.draw do
  devise_for :employees
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
  resources :employees
  resources :templates
  resources :orders do
    resources :attachments
  end
  get '/admin/orders', to: 'home#admin_orders'
  get '/admin/managers', to: 'home#admin_managers'
  get '/admin/templates', to: 'home#admin_templates'
  get '/admin/clients', to: 'home#admin_clients'
  get '/dashboard', to: 'home#dashboard'
  root 'home#index'
end
