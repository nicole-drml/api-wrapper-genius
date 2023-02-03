module Api
    class SearchController < ApplicationController
    
        def album
            binding.pry
            Spotify::Client.album(params[:query])
            render json: album
        end    

        def artist
            Spotify::Client.artist(query)
            render json: artist
        end

        def track
            Spotify::Client.track(query)
            render json: track
        end

        def self.method_missing(name, *args)
            Spotify::Client.name(args)
            render json: name
        end
    end
end