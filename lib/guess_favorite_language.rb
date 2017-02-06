class GuessFavoriteLanguage

  def github_username(username)
    user = Octokit.user username # consider exceptions throw from github API.
    repos = user.rels[:repos].get.data
    languages = repos.map{|x| x.language }.compact
    frequency = languages.each_with_object( Hash.new(0)  ) do |   word,counts|
      counts[word] += 1
    end
    frequency = frequency.sort_by {|_key, value|    value }.reverse
    user_favorite_language = frequency.first.first
    user_favorite_language
  end

end
