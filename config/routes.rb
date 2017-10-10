Rails.application.routes.draw do
  devise_for :users, path: 'sites'
  root to: 'home#index'

  get 'rules', to: 'home#rules', as: 'rules'
  get 'list', to: 'home#list', as: 'list'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
