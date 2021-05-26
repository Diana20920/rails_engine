Rails.application.routes.draw do
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
