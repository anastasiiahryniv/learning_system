Rails.application.routes.draw do
  resources :courses
  resources :users
  root 'static_pages#landing_page'
end
