Ffstrike::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users", :invitations => 'users/invitations'  }

  root 'static_pages#index'

  get 'events' => 'events#search'  

  #home
  get 'about' => 'static_pages#about',  as: 'about'

  #movements
  resources :movements do
    get 'publish' => 'movements#publish', on: :member, as: 'publish'
    get 'profile' => 'movements#user_movements', on: :collection, as: 'user'
    get 'dashboard' => 'movements#dashboard', on: :member, as: 'dashboard' 
    get 'search' => 'movements#search', on: :member, as: 'search'

    resources :events, shallow: true
    resources :unauthenticated_events, only: [:new, :create] 
  end

  #events
  resources :events do
    
    get 'dashboard' => 'events#dashboard', on: :member,  as: 'dashboard' 
    resources :tasks do
      get 'assign' => 'assignments#assign', on: :member, as: 'assign'
    end
    resources :attendees
  end

  get 'events/:id/explanation' => 'events#explanation', as: 'explanation'
  put 'events/:id/approve' => 'events#approve', as: 'approve'

  #mail
  post 'mail_attendees(/:movement_id)(/:event_id)' => 'mail#mail_attendees', as: 'mail_attendees'

  #export CSV
  get 'export_csv/:id' => 'movements#export_csv', as: 'export_csv'

end
