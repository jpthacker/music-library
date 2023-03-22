require "album_repository"

def reset_albums_table
    seed_sql = File.read("spec/seeds_albums.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
    connection.exec(seed_sql)
end

RSpec.describe AlbumRepository do
    before(:each) { reset_albums_table }

    it "creates a repo of albums" do
        album_repo = AlbumRepository.new 
        albums = album_repo.all
        expect(albums[0].id).to eq '1'
        expect(albums[0].title).to eq 'Surfer Rosa'
        expect(albums[0].release_year).to eq '1988'
        expect(albums[0].artist_id).to eq '1'

        expect(albums[1].id).to eq '2'
        expect(albums[1].title).to eq 'Waterloo'
        expect(albums[1].release_year).to eq '1972'
        expect(albums[1].artist_id).to eq '2'
    end

    it "returns a specific album" do
        album_repo = AlbumRepository.new

        album = album_repo.find('1')

        expect(album.id).to eq '1'
        expect(album.title).to eq 'Surfer Rosa'
        expect(album.release_year).to eq '1988'
        expect(album.artist_id).to eq '1'

        album = album_repo.find('2')

        expect(album.id).to eq '1'
        expect(album.title).to eq 'Waterloo'
        expect(album.release_year).to eq '1972'
        expect(album.artist_id).to eq '2'
    end

    it "creates a new album" do
        album_repo = AlbumRepository.new
        album = Album.new
        album.title = "Arrival"
        album.release_year = "1976"
        album.artist_id = "2"

        album_repo.create(album)

        albums = album_repo.all

        expect(albums.last.title).to eq "Arrival"
        expect(albums.last.artist_id).to eq "2"
    end
end
