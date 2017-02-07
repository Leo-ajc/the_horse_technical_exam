require 'spec_helper'
require 'octokit'
require 'guess_favorite_language'

describe GuessFavoriteLanguage do
  describe '#github_username' do

    it 'returns a favorite language given a Github username' do
      favorite_language = GuessFavoriteLanguage.github_username('leo-ajc')
      expect(favorite_language).to eq('Ruby')
      # Could add a http mocking gem like VCR here to speed up the tests.
    end

  end
end
