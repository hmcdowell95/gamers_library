Rails.application.routes.draw do
  resources :users do
    resources :games, only: [:index, :show, :new]
  end
  resources :systems, only: [:index, :show]
  resources :games
  post '/add_systems' => 'systems#add_systems'
  post '/games/:id/last_played' => 'games#last_played'
  post '/games/:id/add_game' => 'games#add_game'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  get '/auth/facebook/callback' => 'sessions#fb_login'
  root 'users#home'

end
