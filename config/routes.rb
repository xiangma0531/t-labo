Rails.application.routes.draw do
  get 'course/user_course'
  get 'course/source_course'
  get 'course/search_course'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
  resources :admins
  resources :users
  resources :sources do
    resources :comments
    collection do
      get 'search'
    end
    resource :likes, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
  root 'sources#index'
  resources :messages
  resources :rooms
  resources :likes, only: :index
end
