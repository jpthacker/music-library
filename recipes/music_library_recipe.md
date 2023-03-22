# Music Library Design Recipe

## 1. The Test Seeds
```sql
--spec/seeds_albums.sql
TRUNCATE TABLE artists, albums RESTART IDENTITY;

INSERT INTO artists (name, genre) VALUES ('Pixies', 'rock');
INSERT INTO albums (title, release_year, artist_id) VALUES ('Surfer Rosa', 1988, 1);
INSERT INTO albums (title, release_year, artist_id) VALUES ('Waterloo', 1972, 2);

--spec/seeds_artists.sql
TRUNCATE TABLE artists RESTART IDENTITY;

INSERT INTO artists (name, genre) VALUES ('Pixies', 'rock');
INSERT INTO artists (name, genre) VALUES ('Abba', 'pop');
```

## 2. The classes

Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by `Repository` for the Repository class name.

```ruby
# file: app.rb

require_relative './lib/album_repository'
require_relative './lib/artist_repository'

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
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
if __FILE__ == $0
  app = Application.new(
    'music_library',
    Kernel,
    AlbumRepository.new,
    ArtistRepository.new
  )
  app.run
end

# Table name: albums

# Model class
# (in lib/album.rb)
class Album
    attr_accessor :id, :title, :release_year, :artist_id
end

# Repository class
# (in lib/albums_repository.rb)
class AlbumRepository
    # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, title, release_year, artist_id FROM albums;

    # Returns an array of album objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, cohort_name FROM students WHERE id = $1;

    # Returns a single Student object.
  end

  # Add more methods below for each operation you'd like to implement.

  def create(album)
    # Executes the SQL query:
    # INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);
    # returns nil
  end

  def update(album)
    # Executes the SQL query:
    # UPDATE albums SET title = $1, release_year = $2, artist_id = $3;
    # returns nil
  end

  def delete(album)
    # Executes the SQL query:
    # DELETE FROM albums WHERE id = $1;
    # returns nil
  end
end

# Model class
# (in lib/artist.rb)
class Artist
    attr_accessor :id, :name, :genre
end

# Repository class
# (in lib/artists_repository.rb)
class ArtistsRepository
    # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists;

    # Returns an array of Artist objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, name, genre FROM artists WHERE id = $1;

    # Returns a single Artist object.
  end
end
```

## 2. Test Examples
```ruby
# 1 Application class
$ ruby app.rb

# Welcome to the music library manager!

# What would you like to do?
#  1 - List all albums
#  2 - List all artists

# Enter your choice: 1
# [ENTER]

# Here is the list of albums:
#  * 1 - Doolittle
#  * 2 - Surfer Rosa
#  * 3 - Waterloo
#  * 4 - Super Trouper
#  * 5 - Bossanova
#  * 6 - Lover
#  * 7 - Folklore
#  * 8 - I Put a Spell on You
#  * 9 - Baltimore
#  * 10 -	Here Comes the Sun
#  * 11 - Fodder on My Wings
#  * 12 -	Ring Ring

# Welcome to the music library manager!

# What would you like to do?
#  1 - List all albums
#  2 - List all artists

# Enter your choice: 2
# [ENTER]

# Here is the list of artists:
# 1	Pixies
# 2	ABBA
# 3	Taylor Swift
# 4	Nina Simone
# 5	Massive Attack

# 2 Album repository

# Get all albums

album_repo = AlbumRepository.new

albums = album_repo.all

albums.length # =>  2

albums[0].id # =>  1
albums[0].title # =>  'Surfer Rosa'
albums[0].release_year # =>  1988
albums[0].artist_id # => 1

albums[1].id # =>  2
albums[1].title # =>  'Waterloo'
albums[1].release_year # =>  1972
albums[1].artist_id # => 2

# Get a single album

album_repo = AlbumsRepository.new

album = album_repo.find(1)

album.id # =>  1
album.name # =>  'Surfer Rosa'
album.release_year # =>  1988
album.artist_id # => 1

# create a new album

album_repo = AlbumsRepository.new
album = Album.new
album.title = "Arrival"
album.release_year = "1976"
album.artist_id = "2"

album_repo.create(album)

albums = album_repo.all

albums.last.title # => "Arrival"
albums.last.artist_id # => 2

# 3. Artist respository

# Return all artists

artists_repo = ArtistsRespository.new

artists = artists_repo.all

artists[0].id # =>  1
artists[0].name # =>  'Pixies'
artists[0].genre # =>  'rock'

artists[1].id # =>  1
artists[1].name # =>  'Abba'
artists[1].genre # =>  'pop'

# Return a specfic artist

artists_repo = ArtistsRespository.new

artist = artists_repo.find(1)

artist.id # =>  1
artist.name # =>  'Pixies'
artist.genre # =>  'rock'

artist = artists_repo.find(2)

artist.id # =>  2
artist.name # =>  'Abba'
artist.genre # =>  'pop'

```

Encode this example as a test.

## 3. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```
