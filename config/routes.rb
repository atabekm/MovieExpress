Rails.application.routes.draw do

  devise_for :users
  devise_scope :user do
    get "sign_in", to: "devise/sessions#new", as: 'signin'
    get "sign_up", to: "devise/registrations#new", as: 'signup'
    get "sign_out", to: "devise/registrations#new", as: 'signout'
  end
  root 'movies#index'

  resources :movies do
    resources :reviews
  end

  get "genres/:genre", to: 'tags#show', as: :genre
  get "genres", to: 'tags#index', as: :genres

  get "search", to: "movies#search", as: :search
end
