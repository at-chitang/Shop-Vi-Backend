Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  api_version(module: 'api/V1', path: { value: 'v1' }) do
    # match '/foos.(:format)' => 'foos#index', :via => :get
    # match '/foos_no_format' => 'foos#index', :via => :get

    resource :users do
      resource :carts, only: %i[show create update destroy] do
        get '/count', to: 'carts#count'
      end
      resources :orders
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
