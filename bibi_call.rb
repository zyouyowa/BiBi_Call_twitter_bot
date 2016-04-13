require 'yaml'
require 'bundler'
Bundler.require
#require 'twitter'
#require 'tweetstream'

class BiBiCall
	attr_accessor :client, :timeline
	def initialize
		keys = YAML.load_file('./keys.yml')
		@client = Twitter::REST::Client.new do |config|
			config.consumer_key = keys["api_key"]
			config.consumer_secret = keys["api_secret"]
			config.access_token = keys["access_token"]
			config.access_token_secret = keys["access_token_secret"]
		end
		TweetStream.configure do |config|
			config.consumer_key = keys["api_key"]
			config.consumer_secret = keys["api_secret"]
			config.oauth_token = keys["access_token"]
			config.oauth_token_secret = keys["access_token_secret"]
			config.auth_method = :oauth
		end
		@timeline = TweetStream::Client.new
	end
	def post(text = "", twitter_id:nil, status_id:nil)
		if status_id
			reply_text = "@#{twitter_id} #{text}"
			@client.update(reply_text, {:in_reply_to_staus_id => status_id})
		else
			@client.update(text)
		end
	end
	def makeCall
		call_arr = "ーっびびっびっびっびっびー".split("")
		"び" + call_arr.shuffle!.join + "！"
	end
	def checkCall(text = "")
		correct_call = "びーっびびっびっびっびっびー！"
		counter = 0
		for i in 0..14 do
			if text[i] == correct_call[i] then
				counter += 1
			end
		end
		' (' + (counter / 15.0 * 100).to_s + '%)'
	end
end