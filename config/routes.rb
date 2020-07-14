Rails.application.routes.draw do
  root 'users#new'
  get '/signup' , to: 'users#new'
  post '/signup', to: 'users#create'
  resources :users
  resources :account_activations, only: [:edit]
end
