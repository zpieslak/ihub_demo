IhubDemo::Application.routes.draw do
  devise_for :users

  root :to => 'pages#home'

  resources :groups
  resources :contacts
end
