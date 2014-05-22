Ffstrike::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users", :invitations => 'users/invitations'  }

  root 'movements#index'

  get 'splash' => 'static_pages#index'

  get 'events' => 'events#search'

  #users
  devise_scope :user do
  ##  get 'new_attendee_user/:event_id' => 'users#new_attendee_user', as: 'new_attendee_user'
    get 'new_attendee_user' => 'users#new_attendee_user'
    post 'create_attendee_user' => 'users#create_attendee_user'
  end


  #home
  get 'about' => 'static_pages#about',  as: 'about'

  #movements
  resources :movements do
    get 'publish' => 'movements#publish', on: :member, as: 'publish'
    get 'profile' => 'movements#user_movements', on: :collection, as: 'user'
    get 'dashboard' => 'movements#dashboard', on: :member, as: 'dashboard'
    get 'search' => 'movements#search', on: :member, as: 'search'
    get 'event_type' => 'movements#event_type', on: :member, as: 'event_type'
    get 'support_network' => 'movements#support_network', on: :member, as: 'support_network'
    resources :events, shallow: true
    resources :unauthenticated_events, only: [:new, :create]
  end

  resources :unauthenticated_submovements, only: [:new, :create]

    get 'new_submovement' => 'movements#new_submovement',  as: 'new_submovement'
  #events
  resources :events do

    get 'dashboard' => 'events#dashboard', on: :member,  as: 'dashboard'
    resources :tasks do
      get 'assign' => 'assignments#assign', on: :member, as: 'assign'
    end
  end

  get 'events/:id/explanation' => 'events#explanation', as: 'explanation'
  put 'events/:id/approve' => 'events#approve', as: 'approve'

  #mail
  post 'mail_attendees(/:movement_id)(/:event_id)' => 'mail#mail_attendees', as: 'mail_attendees'

  #export CSV
  get 'export_csv/:id' => 'movements#export_csv', as: 'export_csv'

  # match 'contact' => 'contact#new', :as => 'new_contact', :via => :get
  # match 'contact' => 'contact#create', :as => 'contact', :via => :post

  get 'contact/:id' => 'contact#new', :as => 'new_contact'
  post 'contact' => 'contact#create', :as => 'contact'

end
