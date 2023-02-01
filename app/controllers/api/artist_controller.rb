module Api
    class ArtistController < ApplicationController
    
        def artist
            Spotify::Client.album('something to tell you')

            render json: artist
        end
    end
end