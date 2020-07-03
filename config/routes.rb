Rails.application.routes.draw do
  resources :users do
    resources :systems, only: [:index, :show]
    resources :games, only: [:index, :show]
  end
  resources :systems do
    resources :games, only: [:new, :edit]
  end
  resources :games
end
