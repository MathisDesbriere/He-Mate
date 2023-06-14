Rails.application.routes.draw do
  get 'relationships/follow_user'
  get 'relationships/unfollow_user'
  resources :comments
  devise_for :users
  root to: "trips#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/edit', to: 'users#edit'
  get 'users/:id/trips', to: 'trips#user_trips', as: 'user_trips'

  post '/relationships/follow_user/:id', to: 'relationships#follow_user', as: :follow_user
  post '/relationships/unfollow_user/:id', to: 'relationships#unfollow_user', as: :unfollow_user

  resources :trips do
    resources :markers, only: [:new, :create]

    resources :activities, only: [:new, :create]
    resources :comments, only: [:create, :destroy]
    member do
      post 'like'
      get 'like'
    end
  end

  resources :chatrooms, only: [:show, :create, :index] do
    resources :messages, only: :create
  end

  resources :activities, only: [:index, :show, :destroy, :create, :new] do
    resources :markers, only: [:new, :create]
  end
  resources :markers, only: [:index, :show, :destroy, :create, :new]
end
