# Spotify Playlist Manager

This is a simple Ruby script for managing playlists in a Spotify-like music service. You can use this script to apply changes to your music data, such as adding songs to playlists, creating new playlists, and removing playlists.

## Prerequisites

Before running this script, ensure you have Ruby installed on your system. If you don't have Ruby installed, you can follow these steps to install it:

### Installing Ruby

Ruby is pre-installed on most Unix-based systems. Open your terminal and check if Ruby is installed by running the following command:

```sh
ruby -v
```

#### Debian/Ubuntu:
```sh
sudo apt update
sudo apt install ruby-full
```

#### macOS (using Homebrew):
```sh
brew install ruby
```
## Usage

The script supports the following actions:

- `add_song_to_playlist`: Adds a song to an existing playlist.
- `add_new_playlist`: Creates a new playlist and adds specified songs to it (at least 1 song).
- `remove_playlist`: Removes an existing playlist.

For the `add_new_playlist` action, you can provide multiple song IDs separated by commas, e.g. `"song_ids": "1,2,3"`.

Please see the included file `changes.json` to see the final aspect of each action.

### Example

spotify.json:
```json
{
    "users": [
      {
        "id": "1",
        "name": "Albin Jaye"
      },
        ...
    ],
    "playlists": [
      {
        "id": "1",
        "owner_id": "2",
        "song_ids": [
          "8",
          "32"
        ]
      },
      ...
    ],
    "songs": [
      {
        "id": "1",
        "artist": "Camila Cabello",
        "title": "Never Be the Same"
      },
        ...
    ]
  }
```

changes.rb:
```json
[
    {
        "action": "add_song_to_playlist",
        "playlist_id": "1",
        "song_id": "9"
    },
    {
        "action": "add_new_playlist",
        "user_id": "4",
        "song_ids": "15,16,17"
    },
    {
        "action": "remove_playlist",
        "playlist_id": "3"
    }
]
```

Shell command:
```sh
ruby spotify.rb spotify.json changes.json
```

### Output

The script will return an output file (output.json) on the same directory with the modifications.

## Scaling Strategies

To scale this application for handling very large input files and/or very large changes files, consider implementing the following strategies:

### 1. Parallel Processing

Use parallel processing techniques to handle data concurrently and improve processing speed. Distribute the workload across multiple threads or processes to take advantage of multicore systems, ultimately enhancing the application's efficiency.

### 2. Database Integration

Integrate a database to efficiently manage and query large amounts of data. Storing data in a database allows for indexing and faster retrieval of specific information.

### 3. Batch Processing

Implement a batch processing mechanism to handle large changes files. Break down the changes into smaller, manageable batches, and process them sequentially or in parallel. This approach prevents overwhelming the system and ensures efficient handling of extensive data sets.

### 4. Error Handling and Logging
Enhance error handling and logging mechanisms to provide meaningful insights and diagnostics, especially when dealing with large data sets where errors might be harder to identify.

## Development time

Time spent on first solution approach (aprox): 90 minutes.

Time spent on fixing errors and testing (aprox): 40 minutes.

Time spent on README (aprox): 20 minutes.

## License

This project is licensed under the MIT License.

Feel free to fork and modify this project for your needs!