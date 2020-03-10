Rails.application.routes.draw do
  root 'drivers#index'
  resources :teams
  resources :drivers
end
