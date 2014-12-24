Rails.application.routes.draw do
  root to: 'pages#home'
  get 'pages/faq'
  get 'pages/contact'
  devise_for :users
  resources :users
  resources :properties do 
    resources :reservations
  end
  resources :reservations, only: :show
  resources :property_attachments, only: :destroy
end
