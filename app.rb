require_relative "lib/database_connection"
require_relative "lib/album_repository"
require_relative "lib/artist_repository"

class Application
    # The Application class initializer
    # takes four arguments:
    #  * The database name to call `DatabaseConnection.connect`
    #  * the Kernel object as `io` (so we can mock the IO in our tests)
    #  * the AlbumRepository object (or a double of it)
    #  * the ArtistRepository object (or a double of it)
    def initialize(database_name, io, album_repository, artist_repository)
        DatabaseConnection.connect(database_name)
        @io = io
        @album_repository = album_repository
        @artist_repository = artist_repository
    end

    def run
        @io.puts "Welcome to music library manager!"
        @io.puts "What would you like to do?\n1 - List all albums\n2 - List all artists"
        @io.puts "Enter your choice: "
        input = @io.gets.chomp
        if input == "1"
            @io.puts "Here is a list of albums:"
            @io.puts albums
        elsif input == "2"
            @io.puts "Here is a list of artists:"
            @io.puts artists
        end
    end

    private

    def albums
        albums_list = ""
        albums = @album_repository.all
        albums.each_with_index { |album, i| albums_list << "* #{i + 1} - #{album.title}\n" }
        return albums_list
    end

    def artists
        artists_list = ""
        artists = @artist_repository.all
        artists.each_with_index do |artist, i|
            artists_list << "* #{i + 1} - #{artist.name}\n"
        end
        return artists_list
    end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
    app =
        Application.new(
            "music_library",
            Kernel,
            AlbumRepository.new,
            ArtistRepository.new,
        )
    app.run
end
