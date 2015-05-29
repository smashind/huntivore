Rails.application.routes.draw do
  root to: 'pages#home'
  match 'faq', to: 'pages#faq', via: :get
  match 'contact', to: 'pages#contact', via: :get
  match 'terms', to: 'pages#terms', via: :get
  match 'about', to: 'pages#about', via: :get
  match 'list', to: 'pages#list', via: :get
  devise_for :users, controllers: {registrations: 'registrations'}
  resources :users do 
    get 'trips'
    get 'hosting'
    get 'favorites'
    get 'messages'
    get 'outfitter_pages'
  end
  resources :properties
  resources :reservations do 
    post :cancel
  end
  resources :property_attachments, only: [:update, :destroy]
  resources :games, path: "game"
  resources :favorites
  resources :outfitters
  get 'special', to: 'pages#special'
  post 'contact_messages', controller: 'contact_messages', action: 'create'
  resources :sent_messages
  resources :message_replies
  post 'payment_notifications', :controller => 'payment_notifications', :action => 'create'
  match "success", :to => 'pages#success', via: :post
  match 'pages/home' => redirect('/'), via: [:get, :post]

  #Admin
  match 'admin', to: 'admin#index', via: :get
  get 'admin/users'
  get 'admin/properties'
  get 'admin/reservations'

end
