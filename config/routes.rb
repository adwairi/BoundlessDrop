Rails.application.routes.draw do
  get 'survey/new'

  get 'survey/edit'

  get 'survey/delete'

  get 'survey/show'

  get 'survey/index'

  devise_for :user
  post '/user', to: 'user#show'
  root 'home#index'
  # get 'home/index'

  # get 'user/edit', to: 'user#show'
  # get 'user/:id',   to: 'user#show'
  # get 'user/edit', to: 'user#edit'
  # post '/sign_in',  to: 'user#create'
  #
  resources :user

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
