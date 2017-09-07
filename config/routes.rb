Rails.application.routes.draw do
  get     '/admin/login',   to: 'sessions#new'
  post    '/admin/login',   to: 'sessions#create'
  delete  '/admin/logout',  to: 'sessions#destroy'
  
  resources :avatar_uploaders

  namespace :admin do
    get     '/dashboard', to: 'dashboard#new', as: 'dashboard'
    resources :profiles, only: %i[show edit update destroy]
  end

  api_version(module: 'api/V1', path: { value: 'v1' }) do
    resource :users do
      resource :carts, only: %i[show create update]
    end

    post '/register', to: 'users#create', as: 'register'

    post '/login', to: 'sessions#create', as: 'login'
    delete '/logout', to: 'sessions#destroy', as: 'logout'
    get '/confirms/:token', to: 'confirms#update', as: 'confirm'

    resources :reset_passwords, only: %i[index show create update]

    resources :shops
    resources :managers
    resources :products
    resources :categories
    get '/products_by_categories/:id', to: 'products_by_categories#show'
    get '/find_products/:id', to: 'find_products#show'
  end
end
