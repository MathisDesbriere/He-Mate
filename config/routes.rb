Rails.application.routes.draw do
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
    resources :activities, only: [:edit, :update]
  end

  resources :activities, only: [:index, :show, :destroy, :create, :new] do
    resources :markers, only: [:new, :create]
  end
  resources :markers, only: [:index, :show, :destroy, :create, :new]
end
