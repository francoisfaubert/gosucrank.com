class PagesController < ApplicationController

    # Required by the tweet boxes to convert
    # text to links.
    require 'rails_autolink'

    before_filter :get_twitch

    def index
        @tweets = Tweet.limit(8).order(id: :desc)
        @youtube = Youtube.order('id').first unless @twitch.is_live
    end

    def stream
    end

    def schedule
    end

    def videohighlights
        @youtube = Youtube.limit(15).order(id: :desc)
    end

    def get_twitch
        @twitch = TwitchStream.first
    end

end
