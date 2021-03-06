Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/most_revenue', to: 'search#most_revenue'
        get '/most_items', to: 'search#most_items'
        get '/:id/items', to: 'items#index'
        get '/:id/revenue', to: 'revenue#show'
      end
      resources :merchants

      get '/revenue', to: 'merchants/revenue#index'

      namespace :items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/:id/merchants', to: 'merchants#show'
      end
      resources :items
    end
  end
end
