Rails.application.routes.draw do
  resources :events, only: [:index, :show]
  resources :orders, only: :create
  resources :authentications, only: :create
end
