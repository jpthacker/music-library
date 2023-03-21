require_relative "database_connection"

class ArtistsRepository
    def all
        DatabaseConnection.connect('music_library_test')
        sql = 'SELECT id, name, genre FROM artists;'
        @result = DatabaseConnection.exec_params(sql, [])
        @result
    end
end