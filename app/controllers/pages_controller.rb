class PagesController < ApplicationController

    # Required by the tweet boxes to convert
    # text to links.
    require 'rails_autolink'

    before_filter :get_twitch

    def index
        @tweets = Tweet.limit(8).order('created_at')
        @youtube = Youtube.order('created_at').first unless @twitch.is_live
    end

    def stream
    end

    def schedule
    end

    def videohighlights
        @youtube = Youtube.limit(15).order('created_at')
    end

    def get_twitch
        @twitch = TwitchStream.first
    end

end
