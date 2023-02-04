module Spotify
    class Request
        TOKEN = 'Bearer BQCuyp4Ol1Hbaw6D2h0miXpp5vCfpBlyt3coR4kyqQmHMXUmkpVgQYcDOG2SMO4fdQ_LYEGMUARa9GyAcXtGouJVO5w5CkihSFM-6W4wT31lVvxAPTCaGvAxpk7odVW0_Obi_iY4I_bmHIBljAj4nqzuKNqqYEaTAssqFG9bc5fgkMA6sPqYqHc'
        BASE_URL = 'https://api.spotify.com/v1/search'

        def self.call(endpoint, query)
            remove_whitespaces = query.delete_prefix('"').delete_suffix('"')
            query_url = remove_whitespaces.gsub((/\s+/), '%20')
            result = HTTParty.get(
                "#{BASE_URL}?q=#{query_url}&type=#{endpoint}",
                :headers => {'Content-Type' => 'application/json',
                authorization: TOKEN}
            )

            unfiltered_data = JSON.parse(result.body)
            if endpoint == 'track' 
                tracks = unfiltered_data['tracks']
                items = tracks['items']
                first_result = items.first
                album_info = first_result['album']
                album_name = album_info['name']
                artists = album_info['artists']
                artist_name = artists.first['name']
                track = first_result['name']
                track_number = first_result['track_number']
                { code: result.code, status: 'Success', ALBUM: album_name, ARTIST: artist_name, TRACK: track, TrackNumber: track_number }
            elsif endpoint == 'album'
                albums = unfiltered_data['albums']
                items = albums['items']
                artist_info = items.first['artists']
                artist_name = artist_info.first['name']
                album_name = items.first['name']
                total_tracks = items.first['total_tracks']
                { code: result.code, status: 'Success', ALBUM: album_name, ARTIST: artist_name, TotalTracks: total_tracks  }
            else

                { code: result.code, status: 'Success', data: unfiltered_data }
            end
            
        rescue HTTParty::Error
            { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
        end

        private
        def self.api_key
            Rails.application.credentials.spotify.api_key!
        end
    end
end