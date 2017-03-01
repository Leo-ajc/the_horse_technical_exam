require 'rails_helper'
require 'octokit'
require 'guess_favorite_language'

describe GuessFavoriteLanguage do
  describe '#github_username' do

    it 'returns a favorite language given a Github username' do
      VCR.use_cassette "guess favorite language" do
        favorite_language = GuessFavoriteLanguage.github_username('leo-ajc')
        expect(favorite_language).to eq('Ruby')
      end
    end

    context 'Testing exception conditions' do

      it 'raises an exception when the Github user is unknown' do
        allow(Octokit).to receive(:user).and_raise(
          Octokit::NotFound
        )
        expect{
          GuessFavoriteLanguage.github_username('unknown_name')
        }.to raise_error(
          GuessFavoriteLanguage::Error::GithubUserNotFound
        )
      end

      it 'raise an exception when the Github user is not found' do
        allow(Octokit).to receive(:user).and_raise(
          Octokit::NotFound
        )
        expect {
          GuessFavoriteLanguage.github_username('leo-ajc')
        }.to raise_error(
          GuessFavoriteLanguage::Error::GithubUserNotFound
        )
      end
    end

  end
end
