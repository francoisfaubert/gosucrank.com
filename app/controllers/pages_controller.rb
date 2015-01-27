class PagesController < ApplicationController

    require 'rails_autolink'

    before_action :before


    def before
        # on each pages we need to know if crank is streaming
        @twitch = TwitchStream.first
    end

    def index
        @twitch = TwitchStream.first
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

end
