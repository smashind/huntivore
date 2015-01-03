Rails.application.routes.draw do
  root to: 'pages#home'
  get 'pages/faq'
  get 'pages/contact'
  devise_for :users
  resources :users
  resources :properties
  resources :reservations
  resources :property_attachments, only: :destroy

  post 'payment_notifications', :controller => 'payment_notifications', :action => 'create'
  match "pages/success", to: 'pages#success', via: [:get, :post]
  match 'pages/home' => redirect('/'), via: [:get, :post]
end
