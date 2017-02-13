require 'spec_helper'
require 'octokit'
require 'guess_favorite_language'
require 'pry'

describe GuessFavoriteLanguage do
  describe '#github_username' do

    it 'returns a favorite language given a Github username' do
      favorite_language = GuessFavoriteLanguage.github_username('leo-ajc')
      expect(favorite_language).to eq('Ruby')
      # Could add a http mocking gem like VCR here to speed up the tests.
    end

    context 'Testing exception conditions' do
      subject do
        GuessFavoriteLanguage.github_username('leo-ajc')
      end

      it 'raise an exception when the Github user is not found' do
        allow(Octokit).to receive(:user).and_raise(
          Octokit::NotFound
        )
        expect {
          subject
        }.to raise_error(
          GuessFavoriteLanguage::Error::GithubUserNotFound
        )
      end
    end

  end
end
