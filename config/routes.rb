Rails.application.routes.draw do
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :retailers, except: %i(new edit)
    end
  end

  post '/login',  to: 'sessions#create', as: "login"
  delete '/logout', to: 'sessions#destroy', as: "logout"
end
