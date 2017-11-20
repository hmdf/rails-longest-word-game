Rails.application.routes.draw do
  get '/game', to: 'plays#game', as: :game
end

Rails.application.routes.draw do
  get '/score', to: 'plays#score', as: :score
end

