Rails.application.routes.draw do
  resources :comments
  devise_for :users
  root to: "trips#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/edit', to: 'users#edit'
  get 'users/:id/trips', to: 'trips#user_trips', as: 'user_trips'

  resources :trips do
    resources :markers, only: [:new, :create]
    resources :activities, only: [:new, :create]
    resources :comments, only: [:create, :destroy]
    member do
      post 'like'
      get 'like'
    end
  end

  resources :activities, only: [:index, :show, :update]
  resources :markers, only: [:index, :show, :destroy, :create, :new]
end
