class FavoritesController < ApplicationController

  def favorite_language
    @favorite_language = GuessFavoriteLanguage.github_username(guess_params)
  end

  rescue_from ActionController::ParameterMissing do
    redirect_to guess_path, alert: 'Please provide a Github username'
  end
  rescue_from GuessFavoriteLanguage::Error::GithubUserNotFound do |e|
    redirect_to guess_path, alert: 'Github username not found'
  end
  rescue_from GuessFavoriteLanguage::Error::GithubApiFault do
    redirect_to guess_path, alert: 'Internal server error'
  end
  rescue_from GuessFavoriteLanguage::Error::Indeterminate do |e|
    redirect_to guess_path, alert: e.message
  end

  def unboxed_html_test
    #render :layout => false
  end

  private

  def guess_params
    params.require(:github_username)
  end

end
