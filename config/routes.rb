Rails.application.routes.draw do
  get '/api/v1/items/find_all', to: 'api/v1/items/search_items#index'
  get '/api/v1/merchants/find', to: 'api/v1/merchants/search_merchant#show'
  namespace :api do
    namespace :v1 do
      resources :items do
        resources :merchant, only: [:index]
      end
      resources :merchants, only: [:index, :show] do
        # resources :merchant_items, only: [:index]
        get '/items', to: 'merchant_items#index'
      end
    end
  end
end
