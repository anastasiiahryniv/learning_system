require 'sidekiq/web'

Rails.application.routes.draw do
  resources :tags

  devise_for :instructors
  devise_for :students

  namespace :instructors do
    resource :profiles, only: %i[show edit update]
  end

  namespace :students do
    resource :profiles, only: %i[show edit update]
  end


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
