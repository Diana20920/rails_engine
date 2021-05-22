Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show] do
        resources :items
      end
      resources :items, only: [:index, :show] do
        resources :merchant, only: [:index]
      end
    end
  end
end
