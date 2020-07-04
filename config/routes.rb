Rails.application.routes.draw do
  resources :users do
    resources :systems, only: [:index, :show]
    resources :games, only: [:index, :show, :new, :edit]
  end
  resources :systems, only: [:index, :show]
  resources :games
end
