Rails.application.routes.draw do
  devise_for :employees
  devise_for :users, :controllers => {
    :omniauth_callbacks => "users/omniauth_callbacks"
  }
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
  match "*path", to: "home#error", via: :all
end
