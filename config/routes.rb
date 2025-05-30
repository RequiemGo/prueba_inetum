Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post   "login",  to: "sessions#create"
      delete "logout", to: "sessions#destroy"
      resources :users do
      namespace :users do
        resources :tasks, only: %i[index create]
      end
    end
      resources :tasks
    end
  end
  post "/graphql", to: "graphql#execute"

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "tasks#index"
end
