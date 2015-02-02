
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
                puts "    Found video ID " + video["id"]["$t"]
		        if Youtube.where(:youtube_id => video["id"]["$t"]).empty?
                    yt = Youtube.create
                    yt.youtube_id = video["id"]["$t"]
                    yt.title = video["title"]["$t"]

                    # when the video gets embedded, the zindex is too high unless we specify
                    # the wmode parameter. This parameter needs to be the first one.
                    yt.url = video["content"]["src"].gsub('?version', '?wmode=transparent&version')
                    yt.yturl = video["link"][0]["href"]

                    if video["media$group"]["media$thumbnail"].length > 2
                        yt.thumbnail = video["media$group"]["media$thumbnail"][2]["url"]
                    else
                        yt.thumbnail = video["media$group"]["media$thumbnail"][0]["url"]
                    end

                    yt.save
		            puts "        Saved."
                end
            end
        end

end
