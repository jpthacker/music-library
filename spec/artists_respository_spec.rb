require "artists_repository"

def reset_artists_table
    seed_sql = File.read("spec/seeds_artists.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
    connection.exec(seed_sql)
end

RSpec.describe ArtistsRepository do
    before(:each) { reset_artists_table }

    it "creates a repo of artists" do
        artists_repo = ArtistsRepository.new
        artists = artists_repo.all
        expect(artists[0]["id"]).to eq "1"
        expect(artists[1]["id"]).to eq "2"
    end
end
