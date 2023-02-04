Rails.application.routes.draw do
    namespace :api do
      get '/album', to: 'queries#album'
      get '/artist', to: 'queries#artist'  
      get '/track', to: 'queries#track'
    end
end
