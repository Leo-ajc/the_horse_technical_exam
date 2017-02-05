Rails.application.routes.draw do

  root to: 'favorites#guess'
  get '/guess', to: 'favorites#guess', as: 'guess'
  post '/favorite_language', to: 'favorites#favorite_language', as: 'favorite_language'

end
