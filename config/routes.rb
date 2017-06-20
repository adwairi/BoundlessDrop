Rails.application.routes.draw do
  get 'user/new'
  get 'user/:id', to: 'user#show'
  post '/users',  to: 'user#create'

  get 'home/index'
  root 'home#index'
  resources :users

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
