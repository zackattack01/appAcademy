Rails.application.routes.draw do
  root to: redirect("/cats")
  resources :cats
  resources :cat_rental_requests
end
