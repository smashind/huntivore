Rails.application.routes.draw do
  get 'games/index'

  get 'games/show'

  get 'games/destroy'

  root to: 'pages#home'
  get 'pages/faq'
  get 'pages/contact'
  get 'pages/success'
  devise_for :users
  resources :users do 
    get 'trips'
    get 'hosting'
  end
  resources :properties
  resources :reservations
  resources :property_attachments, only: :destroy
  resources :games, path: "game"

  post 'payment_notifications', :controller => 'payment_notifications', :action => 'create'
  match "pages/success", :to => 'pages#success', via: [:get, :post]
  match 'pages/home' => redirect('/'), via: [:get, :post]
end
