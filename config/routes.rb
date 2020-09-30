Rails.application.routes.draw do
  devise_for :users, controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'contents#index'

  resources :questions, controller: 'contents', except: :destroy do
    resources :answers, controller: 'messages', only: %i[create edit update] do
      post :vote, on: :member
    end
  end

  resources :users, only: %i[show edit update]
  resources :tags, only: :index

  resources :locations, except: %i[delete index]

  namespace :api do
    namespace :v1 do
      resources :questions, controller: 'contents', only: [:index, :show]
    end
  end
end
