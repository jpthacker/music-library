require_relative "../app"

RSpec.describe Application do
    describe "run method" do
        it "prints albums or artists to the terminal" do
            album = double :fake_album, id: '1', title: 'For Emma, Forever Ago'
            album_repo = double :fake_repo, all: [album]
            artist = double :fake_artist, id: '1,', name: 'Bon Iver'
            artist_repo = double :fake_repo, all: [artist]
            io = double :fake_io
            expect(io).to receive(:puts).with('Welcome to music library manager!').ordered
            expect(io).to receive(:puts).with("What would you like to do?\n1 - List all albums\n2 - List all artists").ordered
            expect(io).to receive(:puts).with('Enter your choice: ').ordered
            expect(io).to receive(:gets).and_return('1').ordered
            expect(io).to receive(:puts).with('Here is a list of albums:').ordered
            expect(io).to receive(:puts).with("* 1 - For Emma, Forever Ago\n")
            app = Application.new('music_library_test', io, album_repo, artist_repo)
            app.run
        end
    end
end
