Rails.application.routes.draw do
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :retailers, only: [:index, :create, :show, :update]
    end
  end
end
