module Spotify
    class Request
        TOKEN = 'Bearer BQDzadDR3J5iRmSEAHyX2EeBEd8S8dYNdJ7cijeM5Z9lJWEk0o7t0wAaxL_thKs_D4pZDUo4C9wBxyhcEiFw_RnE1HcrLL4tHOC3rc7jKoEEBrsl92oTDDpn2D1Fh3H3HrUmE6bjLDnPWwbYR_Et6ROved9hV-M8WEhmX4hq4pHFfIZmocv3HH0'
        BASE_URL = 'https://api.spotify.com/v1/search'

        def self.call(endpoint, query)
            remove_whitespaces = query.delete_prefix('"').delete_suffix('"')
            query_url = remove_whitespaces.gsub((/\s+/), '%20')
            result = HTTParty.get(
                "#{BASE_URL}?q=#{query_url}&type=#{endpoint}",
                :headers => {'Content-Type' => 'application/json',
                authorization: TOKEN}
            )
            { code: result.code, status: 'Success', data: JSON.parse(result.body)}
        rescue HTTParty::Error
            { code: error.http_code, status: error.message, data: Errors.map(error.http_code)}
        end
    end
end