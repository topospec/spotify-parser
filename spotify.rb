require "json"

def progress_of(total, current)
    (current.to_f / total.to_f * 100).to_i
end

# Add a song to a playlist
def add_song_to_playlist(data, playlist_id, song_id)
    playlist = data["playlists"].find { |pl| pl["id"] == playlist_id }
    playlist["song_ids"] << song_id if playlist
end

# Add a new playlist
def add_new_playlist(data, user_id, song_ids)
    new_playlist_id = data["playlists"].length + 1
    data["playlists"] << { 
        "id" => new_playlist_id.to_s, 
        "owner_id" => user_id, 
        "song_ids" => song_ids.split(",") 
    }
end
  

# Remove a playlist
def remove_playlist(data, playlist_id)
  data["playlists"].reject! { |pl| pl["id"] == playlist_id }
end

# Display usage instructions
def display_usage
    puts "Playlist Parser v0.1"
    puts "- Usage:"
    puts "ruby myapp.rb <spotify_file> <changes_file>"
    puts "- Changes File: "
    puts "Changes file must especify the action and the data to perform it."
    puts "- Actions:"
    puts "add_song_to_playlist > Requires: playlist_id, song_id"
    puts "add_new_playlist > Requires: user_id, song_id"
    puts "remove_playlist > Requires: playlist_id"
end

# Check for the correct number of arguments
if ARGV.length != 2
  display_usage
  exit
end

# Load data and changes from CLI arguments
puts "0% - Reading files"
spotify_data = JSON.parse(File.read(ARGV[0]))
changes_data = JSON.parse(File.read(ARGV[1]))

# Apply changes
changes_data.each_with_index do |change, i|
    case change["action"]
    when "add_song_to_playlist"
        puts "#{progress_of(changes_data.length, i+1)}% - Adding song: #{change["song_id"]} to playlist: #{change["playlist_id"]}\r"
        add_song_to_playlist(spotify_data, change["playlist_id"], change["song_id"])
    when "add_new_playlist"
        puts "#{progress_of(changes_data.length, i+1)}% - Adding playlist to user: #{change["user_id"]}"
        add_new_playlist(spotify_data, change["user_id"], change["song_ids"])
    when "remove_playlist"
        puts "#{progress_of(changes_data.length, i+1)}% - Removing playlist: #{change["playlist_id"]}"
        remove_playlist(spotify_data, change["playlist_id"])
    else
        puts "Unknown action: #{change["action"]}"
    end
end

# Save the updated data to output file
File.write("output.json", JSON.pretty_generate(spotify_data))
puts "Changes applied and saved to output.json"