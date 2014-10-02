require 'sidekiq/web'

Ffstrike::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  root 'movements#index'
  # root 'events#index', movement_id: "Congo-Week"

  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users", :invitations => 'users/invitations'  }

  scope "(:locale)", locale: /en|fr|es|it/ do
  # devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users", :invitations => 'users/invitations'  }
    # devise_for :users, skip: :omniauth_callbacks , :controllers => { :registrations => "users", :invitations => 'users/invitations'  }
    # match "/users/auth/:provider",
    #   constraints: { provider: /facebook/ },
    #   to: "omniauth_callbacks#passthru",
    #   as: :user_omniauth_authorize,
    #   via: [:get, :post]

    # match "/users/auth/:action/callback",
    #   constraints: { action: /facebook/ },
    #   to: "omniauth_callbacks",
    #   as: :user_omniauth_callback,
    #   via: [:get, :post]

    get 'mission' => 'static_pages#mission',  as: 'mission'
    get 'template' => 'static_pages#template',  as: 'template'

    #users
    devise_scope :user do
      get 'new_attendee_user' => 'users#new_attendee_user'
      get 'new_member_user' => 'users#new_member_user'
      post 'create_attendee_user' => 'users#create_attendee_user'
      post 'create_member_user' => 'users#create_member_user'
      get 'check_email' => 'users#check_email'
      put 'attendance' => 'users#attendance_notes', as: 'attendance'
      match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup
    end


    get 'splash' => 'static_pages#index'
    get 'events' => 'events#search'

    #movements
    resources :movements,  id: /[^\/]+/ do
      get 'publish' => 'movements#publish', on: :member, as: 'publish'
      get 'profile' => 'movements#my_profile', on: :collection, as: 'user'
      get 'search' => 'movements#search', on: :member, as: 'search'
      get 'event_type' => 'movements#event_type', on: :member, as: 'event_type'
      get 'support_network' => 'movements#support_network', on: :member, as: 'support_network'
      get 'join_team' => 'movements#join_team', on: :member, as: 'join_team'
      resources :events, shallow: true
      resources :unauthenticated_events, only: [:new, :create]
    end

    get 'check_name' => 'movements#check_name'
    get 'my_groups' => 'movements#my_groups', as: 'my_groups'

    resources :unauthenticated_submovements, only: [:new, :create]

    #events
    resources :events, id: /[^\/]+/  do
      get 'download' => 'events#download', on: :member,  as: 'download'
      resources :tasks do
        put 'assign' => 'assignments#assign', on: :member, as: 'assign'
      end
    end
    get 'movements/:id/explanation' => 'movements#explanation', as: 'movement_explanation', id: /[^\/]+/

    get 'my_events' => 'events#my_events', as: 'my_events'
    get 'events/:id/explanation' => 'events#explanation', as: 'explanation', id: /[^\/]+/
    put 'events/:id/approve' => 'events#approve', as: 'approve'
    put 'events/:id/sponsor' => 'events#sponsor', as: 'sponsor'
    put 'assign_volunteer' => 'events#assign_volunteer', as: 'assign_volunteer'
    put 'unattend' => 'events#unattend', as: 'unattend'
    put 'cancel_ownership' => 'movements#cancel_ownership', as: 'cancel_ownership'
    put 'cancel_membership' => 'movements#cancel_membership', as: 'cancel_membership'


    put 'tasks/:id/completed' => 'tasks#completed', as: 'completed'

    #mail
    post 'mail_attendees(/:movement_id)(/:event_id)' => 'mail#mail_attendees', as: 'mail_attendees'
    post 'mail_hosts(/:movement_id)(/:event_id)' => 'mail#mail_hosts', as: 'mail_hosts'

    #export CSV
    get 'export_csv/:id' => 'movements#export_csv', as: 'export_csv'
    get 'export_hosts_csv/:id' => 'movements#export_hosts_csv', as: 'export_hosts_csv'
    get 'export_members_csv/:id' => 'movements#export_members_csv', as: 'export_members_csv'
    get 'export_coordinators_csv/:id' => 'movements#export_coordinators_csv', as: 'export_coordinators_csv'
    get 'export_all_csv/:id' => 'movements#export_all_csv', as: 'export_all_csv'
    get 'export_attendees/:id' => 'events#export_attendees', as: 'export_event_attendees'

      # match 'contact' => 'contact#new', :as => 'new_contact', :via => :get
      # match 'contact' => 'contact#create', :as => 'contact', :via => :post

      get 'contact/:id' => 'contact#new_event_msg', :as => 'new_contact'
      post 'contact' => 'contact#create_event_msg', :as => 'contact'

    get 'attendees_msg/:id' => 'contact#new_attendees_msg', :as => 'new_attendee_msg'
    get 'coordinator_attendee_msg/:id' => 'contact#new_coordinator_attendee_msg', :as => 'new_coordinator_attendee_msg'
    get 'coordinator_hosts_msg/:id' => 'contact#new_coordinator_hosts_msg', :as => 'new_coordinator_hosts_msg'
    get 'new_coordinator_msg/:id' => 'contact#new_coordinator_msg', :as => 'new_coordinator_msg'
    post 'create_coordinator_msg' => 'contact#create_coordinator_msg', :as => 'create_coordinator_msg'
    get 'new_members_msg/:id' => 'contact#new_members_msg', :as => 'new_members_msg'
    post 'create_members_msg' => 'contact#create_members_msg', :as => 'create_members_msg'
    post 'attendees_msg' => 'contact#create_attendees_msg', :as => 'attendee_msg'
    get 'contact/:id/mvmt' => 'contact#new_movement_msg', :as => 'new_mvmt_contact'
    post 'contact/mvmt' => 'contact#create_movement_msg', :as => 'mvmt_contact'
  end
  mount Sidekiq::Web, at: '/sidekiq'
end
