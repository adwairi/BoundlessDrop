Rails.application.routes.draw do
  # resources :question
  resources :option
  resources :answer

  get 'question/add_question'
  get 'question/add_question'
  post 'question/save_question'
  delete 'question/delete/:id', to: 'question#delete'

  get 'survey/index'
  get 'survey/', to: 'survey#index'
  get 'survey/edit'
  get 'survey/add_survey'
  get 'survey/show'
  get 'survey/show/:id', to: 'survey#show'
  get 'survey/delete'
  delete 'survey/delete/:id', to: 'survey#delete'
  post 'survey/save_survey'
  post 'survey/publish', to: 'survey#publish'


  get 'online-survey', to: 'answer#start'
  get 'online-survey/success', to: 'answer#success'
  post 'online-survey', to: 'answer#create'




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
