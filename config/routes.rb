Rails.application.routes.draw do
  resources :users do
    resources :games, only: [:index, :show, :new]
  end
  resources :systems, only: [:index, :show]
  resources :games
  post '/add_systems' => 'systems#add_systems'
  post 'games/:id/last_played' => 'games#last_played'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
  root 'users#home'
end
