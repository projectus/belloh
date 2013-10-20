module PostsHelper
	def readable_time_ago(time)
		tdiff = Time.now - time
		days = (tdiff / 1.day).round
		unless days == 0
			return days.to_s + 'd'
		end
		hours = (tdiff / 1.hour).round
	  unless hours == 0
		  return hours.to_s + 'h'
		end
		minutes = (tdiff / 1.minute).round
	  unless minutes == 0
			return minutes.to_s + 'm'
		end
		seconds = (tdiff / 1.second).round
		return seconds.to_s + 's'
	end
	
end
