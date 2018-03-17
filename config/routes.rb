Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: 'shifts#index'

  resources :sessions
  get '/sessions/callback/:platform', to: 'sessions#callback'

  resources :shifts
  post '/shifts/new', to: 'shifts#create'
end
