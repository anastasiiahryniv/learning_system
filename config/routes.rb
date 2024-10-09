Rails.application.routes.draw do
  devise_for :instructors
  devise_for :students

  resources :courses
  get 'home/students'
  get 'home/instructors'

  root 'home#index'
end
