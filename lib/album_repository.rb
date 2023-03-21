require_relative "album"

class AlbumRepository
    def all
        albums = []
        sql = 'SELECT id, title, release_year, artist_id FROM albums;'
        results = DatabaseConnection.exec_params(sql, [])
        results.each do |result|
            album = Album.new
            album.id = result['id']
            album.title = result['title']
            album.release_year = result['release_year']
            album.artist_id = result['artist_id']
            albums << album
        end
        albums
    end
end