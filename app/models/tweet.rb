class Tweet < ActiveRecord::Base


    USER_NICKNAME = "AxCranK"

    protected

        # Requires the twitter gem
        def self.client
            Twitter::REST::Client.new do |config|
              config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
              config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
              config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
              config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
            end
        end

        def self.clientoptions
            options = {
                count:          20,
                include_rts:    true
            }
            lastTweet = Tweet.last

            # only fetch more recent tweets as to not hit performance issues.
            options[:since_id] = lastTweet.twitter_post_id.to_i unless lastTweet.nil?
            options
        end

    public

        def self.fetchRemoteList
            # Fetch the remote list and create them if they do not exist in our DB
            Tweet.client::user_timeline(USER_NICKNAME, Tweet.clientoptions).each do |remoteTweet|
		        puts "    Found tweet id " + remoteTweet::id.to_s
                if (Tweet.where(:twitter_post_id => remoteTweet::id.to_s).first.nil?)
                    tweet = Tweet.create
                    tweet.text  = remoteTweet::text
                    tweet.twitter_post_id = remoteTweet::id
                    tweet.save
		            puts "        Saved."
                end
            end
        end

        def parsed_text
            text = self.text
            text = text.gsub /@([A-Za-z0-9_]+)/, '<a href="http://twitter.com/\1/">@\1</a>'
            text.gsub /#([A-Za-z0-9_]+)/, '<a href="https://twitter.com/hashtag/\1">#\1</a>'
        end

end
