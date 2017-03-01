require 'octokit'

class GuessFavoriteLanguage

  class << self
    def github_username(username)
      query_octokit(username)
      # There are potentially heaps of Exceptions I might have to rescue
      # In production code I would do a little more research.
    rescue Octokit::NotFound
      raise self::Error::GithubUserNotFound
    rescue Octokit::Error
      raise self::Error::GithubApiFault
    rescue StandardError
      raise self::Error::Indeterminate
    end

    private

    def query_octokit(username)
      user = Octokit.user username
      repos = user.rels[:repos].get.data
      repos = filter_forked_repos(repos)
      languages = repos.map{|x| x.language }.compact
      frequency = languages.each_with_object(Hash.new(0)) do |word,counts|
        counts[word] += 1
      end
      frequency = frequency.sort_by {|_key, value| value }.reverse
      user_favorite_language = frequency.first.first
      user_favorite_language
    end

    def filter_forked_repos(repos)
      repos.select {|x|!x.fork}
    end

  end

  module Error
    class GithubUserNotFound < StandardError
      def initialize(msg="Github username not found")
        super
      end
    end

    class GithubApiFault < StandardError
      def initialize(msg="Github API failure")
        super
      end
    end

    class Indeterminate < StandardError
      # Normally I would write code that doesn't fail, but this is just an example exam
      # Some Github users don't have repositories or return a data structure I don't know
      # For example the Github username 'asdfasdfasdf'
      def initialize(msg="Cannot determine the Github username's favorite language")
        super
      end
    end
  end
end
