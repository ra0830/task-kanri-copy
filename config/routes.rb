Rails.application.routes.draw do
  get 'sessions/new'
  resources :tasks
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
end
