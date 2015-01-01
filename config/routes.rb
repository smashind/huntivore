Rails.application.routes.draw do
  root to: 'pages#home'
  get 'pages/faq'
  get 'pages/contact'
  devise_for :users
  resources :users
  resources :properties
  resources :reservations
  resources :property_attachments, only: :destroy
end
