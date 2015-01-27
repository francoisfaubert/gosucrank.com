class Youtube < ActiveRecord::Base

    require 'net/http'

    USER_NICKNAME = "CranK829"

    protected

        def self.recentvideos
            source = 'https://gdata.youtube.com/feeds/api/videos?author='+USER_NICKNAME+'&orderby=published&max-results=10&v=2&alt=json'
            resp = Net::HTTP.get_response(URI.parse(source))
            JSON.parse(resp.body)
        end

    public

        def self.fetchRemoteList
            Youtube.recentvideos["feed"]["entry"].each do |video|
                if Youtube.where(:youtube_id => video["id"]["$t"]).empty?
                    yt = Youtube.create
                    yt.youtube_id = video["id"]["$t"]
                    yt.title = video["title"]["$t"]
                    yt.url = video["content"]["src"]
                    yt.thumbnail = video["media$group"]["media$thumbnail"][0]["url"]
                    yt.save
                end
            end
        end

end
