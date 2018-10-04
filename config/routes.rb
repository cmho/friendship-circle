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
  post 'admin/site/approve', to: 'admin#approve', as: 'admin_approve'
  post 'admin/site/set_inactive', to: 'admin#set_inactive', as: 'admin_set_inactive'
  get 'admin/site/:id', to: 'admin#edit', as: 'admin_edit'
  post 'admin/site/:id', to: 'admin#update', as: 'admin_update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
