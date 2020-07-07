Rails.application.routes.draw do
  resources :users do
    resources :games, only: [:index, :show, :new, :edit]
  end
  resources :systems, only: [:index, :show]
  resources :games
  post 'add_systems' => 'systems#add_systems'
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  post '/logout' => 'sessions#destroy'
end
