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
      # I normally don't write code that fails. However
      # this is just technical test. I need to insultate
      # the Rails app.
      #
      # This code is very tied to Octokit. I should
      # probably have forked Octkit and add my
      # fork the Gemfile.
      raise self::Error::Indeterminate
    end

    private

    def query_octokit(username)
      user = Octokit.user username
      repos = user.rels[:repos].get.data
      repos = filter_forked_repos(repos)
      languages = repos.map{|x| x.language }.compact # removes nils
      languages = languages.reject { |c| c.empty? } # removes empty strings
      frequency = group_by_and_count(languages)
      frequency = frequency.sort_by {|_key, value| value }.reverse
      # When two languages have the same number of repos
      # just choose one of them.
      user_favorite_language = frequency.first.first
      user_favorite_language
    end

    def group_by_and_count(languages)
      languages.each_with_object(Hash.new(0)) do |word,counts|
        counts[word] += 1
      end
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
