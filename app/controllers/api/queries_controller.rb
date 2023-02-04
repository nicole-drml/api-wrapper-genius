module Api
    class QueriesController < ApplicationController
    
        before_action :set_query_string
        def album
            album = Spotify::Client.album(@qs)
            render json: album
        end    

        def artist
            artist = Spotify::Client.artist(@qs)
            render json: artist
        end

        def track
            track = Spotify::Client.track(@qs)
            render json: track
        end

        private

        def set_query_string
            uri = URI.parse request.url
            @qs = uri.query
        end
    end
end