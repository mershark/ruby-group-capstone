require_relative '../classes/music_album'

describe MusicAlbum do
  describe 'when creating a new MusicAlbum' do
    it 'sets the attributes correctly' do
      album = MusicAlbum.new(true, '2022-01-01')
      album.instance_variable_set('@publish_date', '2022-01-01')
      expect(album.instance_variable_get('@publish_date')).to eq('2022-01-01')
    end
  end

  describe 'when checking if it can be archived' do
    it 'returns false if on_spotify is false' do
      album = MusicAlbum.new(false, '2000-01-01')
      album.instance_variable_set('@publish_date', '2000-01-01')
      expect(album.can_be_archived?).to be false
    end

    it 'returns true if on_spotify is true and the album is over 10 years old' do
      album = MusicAlbum.new(true, '2010-01-01')
      album.instance_variable_set('@publish_date', '2010-01-01')
      expect(album.can_be_archived?).to be true
    end

    it 'returns false if on_spotify is true but the album is less than 10 years old' do
      album = MusicAlbum.new(true, '2021-01-01')
      album.instance_variable_set('@publish_date', '2021-01-01')
      expect(album.can_be_archived?).to be false
    end
  end
end
