Rails.application.routes.draw do
  
  get 'studies/create'
  get 'studies/destroy'
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
  
  resources :users do
    member do
      get :studiedWords, :joinedCourses, :following, :followers 
      resources :courses, only: [:new]
    end
  end

  resources :studies, only: [:create, :destroy]

  resources :courses

  resources :lessons do
    member do
      get :flashcard, :test1
      resources :words, only: [:new]
    end
  end

  resources :words do
    collection do
      get :filter
      post :importFromFile
    end
  end

  resources :account_activations, only: [:edit]
  resources :joins, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  devise_for :users,
  path: '',
  controllers: {omniauth_callbacks: 'omniauth_callbacks' }
end
