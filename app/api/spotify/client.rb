module Spotify
    class Client
        def self.method_missing(name, *args)
            response = Request.call("#{name}", "#{args}")
        end
    end
end