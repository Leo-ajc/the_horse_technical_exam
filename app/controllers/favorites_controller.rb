class FavoritesController < ApplicationController
  def guess
    GuessFavoriteLanguage.github_username()
  end

end
