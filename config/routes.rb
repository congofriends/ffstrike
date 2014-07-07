require 'sidekiq/web'

Ffstrike::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users", :invitations => 'users/invitations'  }

  root 'movements#index'

  get 'splash' => 'static_pages#index'

  get 'events' => 'events#search'

  #users
  devise_scope :user do
    get 'new_attendee_user' => 'users#new_attendee_user'
    post 'create_attendee_user' => 'users#create_attendee_user'
    get 'check_email' => 'users#check_email'
    put 'attendance' => 'users#attendance_notes', as: 'attendance'
  end

  #home
  get 'about' => 'static_pages#about',  as: 'about'

  #movements
  resources :movements do
    get 'publish' => 'movements#publish', on: :member, as: 'publish'
    get 'profile' => 'movements#my_profile', on: :collection, as: 'user'
    get 'search' => 'movements#search', on: :member, as: 'search'
    get 'event_type' => 'movements#event_type', on: :member, as: 'event_type'
    get 'support_network' => 'movements#support_network', on: :member, as: 'support_network'
    resources :events, shallow: true
    resources :unauthenticated_events, only: [:new, :create]
  end

  get 'check_name' => 'movements#check_name'

  get 'my_groups' => 'movements#my_groups', as: 'my_groups'

  resources :unauthenticated_submovements, only: [:new, :create]

  #events
  resources :events do
    get 'download' => 'events#download', on: :member,  as: 'download'
    resources :tasks do
      get 'assign' => 'assignments#assign', on: :member, as: 'assign'
    end
  end

  get 'my_events' => 'events#my_events', as: 'my_events'
  get 'events/:id/explanation' => 'events#explanation', as: 'explanation'
  put 'events/:id/approve' => 'events#approve', as: 'approve'
  put 'assign_volunteer' => 'events#assign_volunteer', as: 'assign_volunteer'
  put 'unattend' => 'events#unattend', as: 'unattend'

  #mail
  post 'mail_attendees(/:movement_id)(/:event_id)' => 'mail#mail_attendees', as: 'mail_attendees'
  post 'mail_hosts(/:movement_id)(/:event_id)' => 'mail#mail_hosts', as: 'mail_hosts'

  #export CSV
  get 'export_csv/:id' => 'movements#export_csv', as: 'export_csv'

  # match 'contact' => 'contact#new', :as => 'new_contact', :via => :get
  # match 'contact' => 'contact#create', :as => 'contact', :via => :post

  get 'contact/:id' => 'contact#new_event_msg', :as => 'new_contact'
  post 'contact' => 'contact#create_event_msg', :as => 'contact'

  get 'contact/:id/mvmt' => 'contact#new_movement_msg', :as => 'new_mvmt_contact'
  post 'contact/mvmt' => 'contact#create_movement_msg', :as => 'mvmt_contact'

  mount Sidekiq::Web, at: '/sidekiq'
end
