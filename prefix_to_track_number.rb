require "iTunesLib"

ITunes.app do |itunes|
	sels = itunes.selected_tracks
	
	if sels.nil?
		puts "No selection"
		break
	end
	
	1.upto(sels.count) do |i|
		track = sels.item(i)
		if track.name =~ /^\s*(\d+)/
			track.track_number = $1.to_i
		end
	end
end
