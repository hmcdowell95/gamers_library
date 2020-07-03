Rails.application.routes.draw do
  resources :users do
    resources :systems, only: [:index, :show]
    resources :games, only: [:index, :show]
  end
  resources :systems
  resources :games
end
