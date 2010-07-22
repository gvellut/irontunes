require "iTunesLib"


if ARGV.length == 0
	puts "Usage: #{__FILE__} [a|l|n]"
	puts "a => artist, l => album, n => song name"
	exit
end

scope = ARGV.shift
if scope !~ /a|l|n/
	puts "Bad scope"
	exit                  
end


ITunes.app do |itunes|
	sels = itunes.selected_tracks

	if sels.nil?
		puts "No selection"
		break
	end

	1.upto(sels.count) do |i|
		track = sels.item(i)
		
		if scope == "n"
			name = track.name
		elsif scope =="l"
			name = track.album
		else
			name = track.artist
		end
		
		name = name.split(" ").map do |word| 
			word.capitalize
		end.join(" ")
				
		if scope == "n"
			track.name = name
		elsif scope =="l"
			track.album = name
		else
			track.artist = name
		end

	end
end