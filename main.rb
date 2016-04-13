require "./bibi_call.rb"

bot = BiBiCall.new

begin
	bot.timeline.userstream do |status|
		#タイムラインが流れる度に処理される
		twitter_id = status.user.screen_name
		contents = status.text
		status_id = status.id
		if !contents.index("RT")
			if contents =~ /^@bibi_call\s*/
				if contents =~ /bibicall/
					text = bot.makeCall
					text += bot.checkCall(text)
					puts text
					bot.post(text, twitter_id:twitter_id, status_id:status_id)			
				end
			end
		end
		sleep 2
	end
rescue => em
	puts Time.now
	p em
	sleep 2
	retry
rescue Interrupt
	exit 1
end