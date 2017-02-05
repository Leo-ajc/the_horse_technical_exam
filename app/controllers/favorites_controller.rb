class FavoritesController < ApplicationController
  def guess

  end

  def favorite_language
    client = GuessFavoriteLanguage.new
    @favorite_language = client.github_username(guess_params)
  end

  private

  def guess_params
    params.require(:github_username)
  end

end
