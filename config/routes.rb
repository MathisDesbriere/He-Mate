Rails.application.routes.draw do
  devise_for :users
  root to: "trips#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"


  resources :trips do
    resources :markers, only: [:new, :create]
    resources :activities, only: [:new, :create]
  end

  resources :activities, only: [:index, :show, :update]

  resources :markers, only: [:index, :show, :destroy, :create, :new]
end
