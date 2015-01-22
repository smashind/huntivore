Rails.application.routes.draw do
  root to: 'pages#home'
  get 'pages/faq'
  get 'pages/contact'
  get 'pages/success'
  devise_for :users
  resources :users do 
    get 'trips'
    get 'hosting'
    get 'favorites'
  end
  resources :properties
  resources :reservations do 
    post :cancel
  end
  resources :property_attachments, only: :destroy
  resources :games, path: "game"
  resources :favorites

  post 'payment_notifications', :controller => 'payment_notifications', :action => 'create'
  match "pages/success", :to => 'pages#success', via: [:get, :post]
  match 'pages/home' => redirect('/'), via: [:get, :post]
end
