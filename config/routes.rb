require 'sidekiq/web'

Rails.application.routes.draw do
  resources :tags

  devise_for :instructors
  devise_for :students

  authenticate :instructors do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :courses do
    resources :enrollments, only: [:create]
  end

  resources :enrollments, only: [:index]

  get 'home/students'
  get 'home/instructors'

  delete 'sign_out', to: 'application#sign_out', as: 'destroy_session'
  root 'home#index'
end
