require "iTunesLib"
require "FileUtils"

export_dir = "."
if ARGV.length <= 1
	puts "Exporting to current directory..."
else 
	puts "Exporting to " + ARGV[0] + "..."
	export_dir = ARGV[0]
end

def escape_file_name(file)
	file.gsub(/([^ a-zA-Z0-9_.-]+)/,"_")
end

ITunes.app do |itunes|
	sels = itunes.selected_tracks

	if sels.nil?
		puts "No selection"
		break
	end

	1.upto(sels.count) do |i|
		track = sels.item(i)
		file = track.location
		track_export_dir = File.join(export_dir,
				 escape_file_name(track.artist || "Unknown Artist"),
				 escape_file_name(track.album || "Unknown Album"))
	        FileUtils.mkdir_p(track_export_dir)
		FileUtils.cp(file, track_export_dir)
	end
end



