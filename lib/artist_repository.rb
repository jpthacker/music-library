require_relative "artist_repository"

class ArtistRepository
    def all
        artists = []
        sql = 'SELECT id, name, genre FROM artists;'
        results = DatabaseConnection.exec_params(sql, [])

        results.each do |result|
            artist = Artist.new
            artist.id = result['id']
            artist.name = result['name']
            artist.genre = result['genre']
            artists << artist
        end
        artists
    end

    def find(id)
        sql = "SELECT id, name, genre FROM artists WHERE id = $1;"
        params = [id]
        result = DatabaseConnection.exec_params(sql, params)
        record = result[0]
        artist = Artist.new
        artist.id = record['id']
        artist.name = record['name']
        artist.genre = record['genre']
        artist
    end
end