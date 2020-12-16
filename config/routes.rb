Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get '/:id/items', to: 'items#index'
      end
      resources :merchants

      namespace :items do
        get '/:id/merchants', to: 'merchants#show'
      end
      resources :items
    end
  end
end
