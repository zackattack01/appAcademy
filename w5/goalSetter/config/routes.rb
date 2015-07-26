Rails.application.routes.draw do
  resources :users do
    resources :goals, only: [:new]
  end

  resources :goals, except: [:new]
  resource :session, only: [:new, :create, :destroy]
  root 'users#index'
end
