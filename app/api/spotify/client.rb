module Spotify
    class Client
        def self.method_missing(name, *args)
            if %i{album artist track}.include? name
                response = Request.call("#{name}", args[0])
            end
        end
    end
end
