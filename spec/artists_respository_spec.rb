require "artist_repository"
require "artist"

def reset_artists_table
    seed_sql = File.read("spec/seeds_artists.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
    connection.exec(seed_sql)
end

RSpec.describe ArtistRepository do
    before(:each) { reset_artists_table }

    it "returns a repo of artists" do
        artists_repo = ArtistRepository.new
        artists = artists_repo.all
        expect(artists[0].id).to eq "1"
        expect(artists[0].name).to eq 'Pixies'
        expect(artists[0].genre).to eq 'rock'
        expect(artists[1].id).to eq "2"
        expect(artists[1].name).to eq 'Abba'
        expect(artists[1].genre).to eq 'pop'
    end

    it "returns a spcific artist" do
        artists_repo = ArtistRepository.new

        artist = artists_repo.find(1)

        expect(artist.id).to eq "1"
        expect(artist.name).to eq 'Pixies'
        expect(artist.genre).to eq 'rock'

        artist = artists_repo.find(2)

        expect(artist.id).to eq "2"
        expect(artist.name).to eq 'Abba'
        expect(artist.genre).to eq 'pop'
    end
end
