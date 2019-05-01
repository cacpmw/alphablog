Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :articles
  resources :users, except: [:new]
  root 'welcome#home'

  get 'signup', to: 'users#new'
end
