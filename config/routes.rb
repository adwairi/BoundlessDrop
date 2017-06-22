Rails.application.routes.draw do
  get 'question/add_question'

  get 'survey/edit'

  get 'survey/delete'
  delete 'survey/delete/:id', to: 'survey#delete'

  get 'survey/show'
  get 'survey/show/:id', to: 'survey#show'

  get 'survey/index'
  get 'survey/', to: 'survey#index'



  get 'survey/add_survey'
  post 'survey/save_survey'

  get 'question/add_question'
  post 'question/save_question'
  delete 'question/delete/:id', to: 'question#delete'


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
