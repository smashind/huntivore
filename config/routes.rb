Rails.application.routes.draw do
  root to: 'pages#home'
  get 'faq', to: 'pages#faq', via: :get
  get 'contact', to: 'pages#contact', via: :get
  get 'terms', to: 'pages#terms', via: :get
  get 'about', to: 'pages#about', via: :get
  get 'list', to: 'pages#list', via: :get
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
  get "success", :to => 'pages#success', via: :post
  get 'pages/home' => redirect('/'), via: [:get, :post]

  #Admin
  get 'admin', to: 'admin#index', via: :get
  get 'admin/users'
  get 'admin/properties'
  get 'admin/reservations'

  constraints Domain do 
    get 'https://protected-brook-4630.herokuapp.com', to: redirect(domain: 'http://www.huntivore.com')
  end
end
