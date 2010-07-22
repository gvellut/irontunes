require "iTunesLib"


if ARGV.length == 0
	puts "Usage: #{__FILE__} [a|l|n] [character]? [replacement]?"
	puts "a => artist, l => album, n => song name"
	puts "Default : character => '_' ; replacement => ' '"
	exit
end

scope = ARGV.shift
if scope !~ /a|l|n/
	puts "Bad scope"
	exit                  
end

char_to_replace = "_"
if ARGV.length > 0
	char_to_replace = ARGV.shift	
end if

replacement = " "
if ARGV.length > 0
	replacement	= ARGV.shift	
end if


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
		
		name = name.replace(char_to_replace, replacement)
				
		if scope == "n"
			track.name = name
		elsif scope =="l"
			track.album = name
		else
			track.artist = name
		end

	end
end