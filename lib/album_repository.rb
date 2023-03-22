require_relative "album_repository"

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

    def find(id)
        sql = "SELECT id, title, release_year, artist_id FROM albums WHERE id = $1;"
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)
        record = result[0]
        album = Album.new
        album.id = record['id']
        album.title = record['title']
        album.release_year = record['release_year']
        album.artist_id = record['artist_id']
        album
    end

    def create(album)
        sql = 'INSERT INTO albums (title, release_year, artist_id) VALUES ($1, $2, $3);'
        params = [album.title, album.release_year, album.artist_id]
        DatabaseConnection.exec_params(sql, params)
        return nil
    end
end