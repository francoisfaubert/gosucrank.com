
class Youtube < ActiveRecord::Base

    require 'net/http'

    USER_NICKNAME = "CranK829"
    UPLOADS_KEY = "UUS2OAdHoLt-9T6cG9A2H49Q"

    protected

        def self.recentvideos
            # Use this link to gain the uploads playlist id
            #source = "https://www.googleapis.com/youtube/v3/channels?part=contentDetails&forUsername=#{USER_NICKNAME}&key=#{ENV["Youtube_key"]}"
            source = "https://www.googleapis.com/youtube/v3/playlistItems?part=snippet&playlistId=#{UPLOADS_KEY}&key=#{ENV["Youtube_key"]}"
            resp = Net::HTTP.get_response(URI.parse(source))
            JSON.parse(resp.body)
        end

    public

        def self.fetchRemoteList
            Youtube.recentvideos["items"].each do |video|
                puts "    Found video ID " + video["id"]
		        if Youtube.where(:youtube_id => video["id"]).empty?
                    yt = Youtube.create
                    yt.youtube_id = video["id"]
                    yt.title = video["snippet"]["title"]
                    yt.url = video["snippet"]["resourceId"]["videoId"]
                    yt.thumbnail = video["snippet"]["thumbnails"]["standard"]["url"]
                    yt.save
		            puts "        Saved."
                end
            end
        end

        def get_url
            unless url.nil?
                if url =~ /http/i
                    url
                else
                    "https://www.youtube.com/v/" + url
                end
            end
        end

end
