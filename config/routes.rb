Rails.application.routes.draw do
  devise_for :users, path: 'sites'

  root to: 'home#index'

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'join', to: 'devise/registrations#new'
  end

  get 'rules', to: 'home#rules', as: 'rules'
  get 'list', to: 'sites#index', as: 'list'
  get 'sites/:id', to: 'sites#show', as: 'sites'

  get 'admin', to: 'admin#index', as: 'admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
