require_relative "artist"

class ArtistsRepository
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
end