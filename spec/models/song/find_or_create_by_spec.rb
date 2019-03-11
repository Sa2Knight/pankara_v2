RSpec.describe Song, type: :model do
  describe 'find_or_create_by' do
    subject do
      Song.find_or_create_by(song_name: song_name, artist_name: artist_name)
    end

    let!(:song) do
      FactoryBot.create(
        :song,
        name: '天体観測',
        artist: FactoryBot.create(:artist, name: 'BUMP OF CHICKEN')
      )
    end

    context '既に該当の楽曲が存在する場合' do
      let(:song_name) { '天体観測' }
      let(:artist_name) { 'BUMP OF CHICKEN' }

      it '既存の楽曲を取得する' do
        expect(subject.id).to eq song.id
      end

      it '楽曲の総数は変わらない' do
        expect { subject }.not_to change { Song.count }.from(1)
      end
    end

    context '該当の歌手のみ存在する場合' do
      let(:song_name) { 'ロストマン' }
      let(:artist_name) { 'BUMP OF CHICKEN' }

      it '新規楽曲を取得する' do
        expect(subject.id).not_to eq song.id
        expect(subject.name).to eq song_name
      end

      it '楽曲の総数が増える' do
        expect { subject }.to change { Song.count }.from(1).to(2)
      end

      it '歌手の総数は変わらない' do
        expect { subject }.not_to change { Artist.count }.from(1)
      end
    end

    context '楽曲も歌手も存在しない場合' do
      let(:song_name) { '天体観測' }
      let(:artist_name) { 'DUBUMP' }

      it '新規楽曲を取得する' do
        expect(subject.id).not_to eq song.id
        expect(subject.name).to eq song_name
      end

      it '楽曲の総数が増える' do
        expect { subject }.to change { Song.count }.from(1).to(2)
      end

      it '歌手の総数が増える' do
        expect { subject }.to change { Artist.count }.from(1).to(2)
      end
    end
  end
end
