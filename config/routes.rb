Rails.application.routes.draw do
  get 'property_attachments/destroy'

  root to: 'pages#home'
  get 'pages/faq'
  get 'pages/contact'
  devise_for :users
  resources :users
  resources :properties
  resources :property_attachments, only: :destroy
end
