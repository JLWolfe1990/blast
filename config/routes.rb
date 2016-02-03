Rails.application.routes.draw do
  devise_for :users

  root to: 'users#dashboard'

  resources :events, only:[:new, :create]
end
