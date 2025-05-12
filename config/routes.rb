require 'sidekiq/web'

Rails.application.routes.draw do
  resources :tags

  devise_for :instructors
  devise_for :students

  namespace :instructors do
    resource :profiles, only: %i[show edit update]
    get 'instructors/pdf/:id', to: 'profiles#download_pdf'
  end

  namespace :students do
    resource :profiles, only: %i[show edit update]
    get 'students/pdf/:id', to: 'profiles#download_pdf'
  end


  authenticate :instructors do
    mount Sidekiq::Web => '/sidekiq'
  end

  scope "(:locale)", locale: /en|es/ do
    resources :courses do
      member do
        patch :start
      end

      resources :comments do
        resources :replies, controller: 'comments'
      end

      resources :enrollments, only: [:create]
    end
  end

  resources :enrollments, only: [:index]

  get 'home/students'
  get 'home/instructors'

  delete 'sign_out', to: 'application#sign_out', as: 'destroy_session'
  root 'home#index'
end
