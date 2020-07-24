Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root 'static_pages#home'
  
  get 'studies/create'
  get 'studies/destroy'
  
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
      get :studiedWords, :joinedCourses, :following, :followers, :createdCourses
    end
    resources :courses, only: [:new]
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

  # active account by mails
  resources :account_activations, only: [:edit]
  # reset password
  resources :password_resets, only:[:new, :create, :edit, :update]
  
  resources :joins, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  
  devise_for :users,
  path: '',
  controllers: {omniauth_callbacks: 'omniauth_callbacks' }
end
