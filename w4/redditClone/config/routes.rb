Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show, :index]
  resource :session, only: [:new, :create, :destroy]

  resources :subs, except: :destroy
  resources :posts, only: [:new, :edit]

  root "sessions#new"
end
