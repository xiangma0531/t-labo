Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations'
  }
  devise_for :admins, controllers: {
    session: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations'
  }
end
