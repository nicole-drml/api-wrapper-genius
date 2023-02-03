module Spotify
    class Request
        TOKEN = 'Bearer BQAPP0pXg82yNHDVwd_biv8_UDHIk63LpTEgn_m837IcSd8nWCjamHFP_ylMJNcrFYZtirJO5b6Ewezf1dSzV7QqpYQ4OiXoIv-di6q8Q4nLsROQ4IJDEygRgLPMLxwaJEPFMhj9dPO3oluamxUahsknavakMRRKOSwBEsAc_QgaaIlxq8rplNg'
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