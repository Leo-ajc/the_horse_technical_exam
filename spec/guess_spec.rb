require 'spec_helper'
require 'guess_favorite_language'

describe GuessFavoriteLanguage do
  describe '#github_username' do
    it 'returns a favorite language given a Github username' do
      client = GuessFavoriteLanguage.new
      favorite_language = client.github_username('leo-ajc')
      expect(favorite_language).to eq('Ruby')
    end
  end
end
