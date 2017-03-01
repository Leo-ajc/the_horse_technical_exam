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

    it "does not count forked repos" do
      VCR.use_cassette "does not count forked repos", record: :none do
        # This is a readonly cassette, a webmock
        # [
        #   {"language":"Ruby","fork":false},
        #   {"language":"Clojure", "fork":true},
        #   {"language":"Clojure", "fork":true}
        # ]
        favorite_language = GuessFavoriteLanguage.github_username('leo-ajc')
        expect(favorite_language).to eq('Ruby')
      end
    end

    it "ignores repos with empty string value for language" do
      VCR.use_cassette "ignores repos with empty string value for language", record: :none do
        # This is a readonly cassette, a webmock
        # [
        #   {"language":"Ruby","fork":false},
        #   {"language":"", "fork":false},
        #   {"language":"", "fork":false}
        # ]
        favorite_language = GuessFavoriteLanguage.github_username('leo-ajc')
        expect(favorite_language).to eq('Ruby')
      end
    end

    it "ignores repos with nil value for language" do
      VCR.use_cassette "ignores repos with nil value for language" do
        # This is a readonly cassette, a webmock
        # [
        #   {"language":"Ruby","fork":false},
        #   {"language":nil, "fork":false},
        #   {"language":nil, "fork":false}
        # ]
        favorite_language = GuessFavoriteLanguage.github_username('leo-ajc')
        expect(favorite_language).to eq('Ruby')
      end
    end

    context 'Testing exception conditions' do
      context 'raises an exception with the Github user' do
        it 'is unknown' do
          allow(Octokit).to receive(:user).and_raise(
            Octokit::Error
          )
          expect{
            GuessFavoriteLanguage.github_username('unknown_name')
          }.to raise_error(
            GuessFavoriteLanguage::Error::GithubApiFault
          )
        end

        it 'is not found' do
          allow(Octokit).to receive(:user).and_raise(
            Octokit::NotFound
          )
          expect {
            GuessFavoriteLanguage.github_username('leo-ajc')
          }.to raise_error(
            GuessFavoriteLanguage::Error::GithubUserNotFound
          )
        end

        it 'has no repos' do
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
end
