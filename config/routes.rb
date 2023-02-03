Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

    namespace :api do
      get '/album', to: 'search#album'
      get '/artist', to: 'search#artist'
      get '/track', to: 'search#track'
    end
end
