require 'resque_web'

Rails.application.routes.draw do
  devise_for :users

  root to: 'users#dashboard'

  resources :events, except: [:show]

  mount ResqueWeb::Engine => "/resque_web"
end
