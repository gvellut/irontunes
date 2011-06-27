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
	playlist = itunes.browser_window.selected_playlist

	if playlist.nil?
		puts "No selection"
		break
	end

	tracks = playlist.tracks
	1.upto(tracks.count) do |i|
		track = tracks.item(i)
		file = track.location
		track_export_file = "#{i}_" + File.basename(file)
		track_export_dir = File.join(export_dir,
				 escape_file_name(playlist.name || "Unknown Playlist"))
	        FileUtils.mkdir_p(track_export_dir)
		FileUtils.cp(file, File.join(track_export_dir, track_export_file))
	end
	
end




