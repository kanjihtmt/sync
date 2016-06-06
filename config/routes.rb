Rails.application.routes.draw do
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :retailers, except: %i(new edit)
      resources :users, only: %i(index show create)

      post '/login',  to: 'sessions#create', as: "login"
      delete '/logout', to: 'sessions#destroy', as: "logout"
    end
  end
end
