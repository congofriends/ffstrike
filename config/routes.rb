require 'sidekiq/web'

Ffstrike::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  #home
  root 'movements#index'

  scope "(:locale)", locale: /en|fr|es/ do
  # devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users", :invitations => 'users/invitations'  }
    devise_for :users, skip: :omniauth_callbacks , :controllers => { :registrations => "users", :invitations => 'users/invitations'  }
    match "/users/auth/:provider",
      constraints: { provider: /facebook/ },
      to: "omniauth_callbacks#passthru",
      as: :user_omniauth_authorize,
      via: [:get, :post]

    match "/users/auth/:action/callback",
      constraints: { action: /facebook/ },
      to: "omniauth_callbacks",
      as: :user_omniauth_callback,
      via: [:get, :post]

    get 'about' => 'static_pages#about',  as: 'about'

    #users
    devise_scope :user do
      get 'new_attendee_user' => 'users#new_attendee_user'
      post 'create_attendee_user' => 'users#create_attendee_user'
      get 'check_email' => 'users#check_email'
      put 'attendance' => 'users#attendance_notes', as: 'attendance'
    end

    get 'splash' => 'static_pages#index'
    get 'events' => 'events#search'

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
    put 'events/:id/sponsor' => 'events#sponsor', as: 'sponsor'
    put 'assign_volunteer' => 'events#assign_volunteer', as: 'assign_volunteer'
    put 'unattend' => 'events#unattend', as: 'unattend'

    put 'tasks/:id/completed' => 'tasks#completed', as: 'completed'

    #mail
    post 'mail_attendees(/:movement_id)(/:event_id)' => 'mail#mail_attendees', as: 'mail_attendees'
    post 'mail_hosts(/:movement_id)(/:event_id)' => 'mail#mail_hosts', as: 'mail_hosts'

    #export CSV
    get 'export_csv/:id' => 'movements#export_csv', as: 'export_csv'
    get 'export_attendees/:id' => 'events#export_attendees', as: 'export_event_attendees'

      # match 'contact' => 'contact#new', :as => 'new_contact', :via => :get
      # match 'contact' => 'contact#create', :as => 'contact', :via => :post

      get 'contact/:id' => 'contact#new_event_msg', :as => 'new_contact'
      post 'contact' => 'contact#create_event_msg', :as => 'contact'

    get 'attendees_msg/:id' => 'contact#new_attendees_msg', :as => 'new_attendee_msg'
    post 'attendees_msg' => 'contact#create_attendees_msg', :as => 'attendee_msg'

    get 'contact/:id/mvmt' => 'contact#new_movement_msg', :as => 'new_mvmt_contact'
    post 'contact/mvmt' => 'contact#create_movement_msg', :as => 'mvmt_contact'
  end
  mount Sidekiq::Web, at: '/sidekiq'
end
