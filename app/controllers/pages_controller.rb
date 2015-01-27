class PagesController < ApplicationController

    require 'rails_autolink'

    def index
        @twitch = TwitchStream.first
        @tweets = Tweet.limit(8).order('created_at')
        @youtube = Youtube.order('created_at').first unless @twitch.is_live
    end

    def stream
        @twitch = TwitchStream.first
    end

    def schedule
        @twitch = TwitchStream.first
    end

    def videohighlights
        @youtube = Youtube.limit(15).order('created_at')
    end

end
