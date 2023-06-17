Rails.application.routes.draw do

  require 'sidekiq/web'

# Configure Sidekiq-specific session middleware
  Sidekiq::Web.use ActionDispatch::Cookies
  Sidekiq::Web.use ActionDispatch::Session::CookieStore, key: "_interslice_session"

  Myapp::Application.routes.draw do
    mount Sidekiq::Web => "/sidekiq"
    # ...
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :drivers, only: %i(index create) do
        collection do
          post '/login', to: 'drivers#login'
        end
      end
      resources :trucks, only: [:index] do
        collection do
          get '/assigned_trucks', to: 'trucks#assigned_trucks'
        end
        put '/assign_truck', to: 'trucks#assign_truck'
      end
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
