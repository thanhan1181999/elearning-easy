Rails.application.routes.draw do
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/about', to: 'static_pages#about'
  get 'sessions/new'

  get '/signup' , to: 'users#new'
  post '/signup', to: 'users#create'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  delete '/course/delete', to: 'courses#destroy'
  resources :users
  resources :courses
  resources :lessons
  resources :words
  resources :account_activations, only: [:edit]
end
