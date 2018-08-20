Rails.application.routes.draw do

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
  
  root 'workflow_templates#index'
  get 'access/menu'
  get 'access/login'
  get 'states/new'
  get 'states/index'
  get 'states/edit'
  get 'states/delete'
  get 'state/new'
  get 'state/index'
  get 'state/edit'
  get 'state/delete'
  post 'access/attempt_login'
  get 'access/logout'
  get 'home', :to => 'access#home'
  #get 'workflow_templates/index'
  #get 'workflow_templates/show'
  #get 'workflow_templates/new'
  #get 'workflow_templates/create'
  #get 'workflow_templates/edit'
  #get 'workflow_templates/delete'
  #get 'workflow_templates/destroy'
  get 'workflow_templates/addedge'
  post 'workflow_templates/addedge'
  get 'workflow_templates/removeedge'
  post 'workflow_templates/removeedge'
  get 'demo/index'

  resources :workflow_templates do
    member do
      get :delete
    end
  end

  resources :states do
    member do
      get :delete
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
