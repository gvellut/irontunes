require "iTunesLib"


if ARGV.length <= 1
	puts "Usage: #{__FILE__} [a|l|n] [<f or b> <num chars to remove>]+"
	puts "a => artist, l => album, n => song name"
	exit
end

scope = ARGV.shift
if scope !~ /a|l|n/
	puts "Bad scope"
	exit                  
end

rff = nil
rfb = nil

ARGV.each_with_index do |a,i|
	if a == "f"
		rff = ARGV[i + 1].to_i if i < ARGV.length - 1
	elsif a == "b"
		rfb = ARGV[i + 1].to_i if i < ARGV.length - 1
	end
end

if rff.nil? and rfb.nil?
	puts "Nothing to do"
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
		
		if !rff.nil?
			#name is an immutable .NET string
			name = name.slice(rff..-1) 
		end
		
		if !rfb.nil?
			name = name.slice(0..-(rfb+1))
		end
		
		if scope == "n"
			track.name = name
		elsif scope =="l"
			track.album = name
		else
			track.artist = name
		end

	end
end