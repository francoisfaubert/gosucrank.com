class TwitchStream < ActiveRecord::Base

    require 'twitch'

    USER_NICKNAME = "crank"

    protected

        # Requires the dustinlakin/twitch-rb gem
        def self.client
            # because we stay read-only, no need for configuration
            Twitch.new()
        end

        def self.stream
            stream = TwitchStream.client.getStream(USER_NICKNAME)
            responseBody = stream[:body]
            streamData = responseBody["stream"]
            streamData
        end

    public

        def self.fetchRemoteList
            stream = TwitchStream.first_or_create
            # Fetch the stream details. If we can obtain them, then the stream is running.
            stream.is_live = !TwitchStream.stream.nil?
            stream.save
        end

end
