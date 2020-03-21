Rails.application.routes.draw do
  get 'sessions/new'
  resources :employees
end
