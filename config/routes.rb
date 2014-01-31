Ffstrike::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users", :invitations => 'users/invitations'  }

  root 'static_pages#index'

  get 'events' => 'events#search'  

  #home
  get 'about' => 'static_pages#about',  as: 'about'

  #movements
  resources :movements do

    get 'my_movements' => 'movements#user_movements', on: :collection, as: 'user'
    get 'dashboard' => 'movements#dashboard', on: :member, as: 'dashboard' 
    get 'search' => 'movements#search', on: :member, as: 'search'

    resources :events, shallow: true
    resources :tasks do
      get 'assign' => 'assignments#assign', on: :member, as: 'assign'
    end
  end
  get 'visitor/:id' => 'movements#visitor', as: 'visitor' 

  #events
  resources :events do
    resources :tasks do
      get 'assign' => 'assignments#assign', on: :member, as: 'assign'
    end
    resources :attendees
  end
  get 'events/:id/explanation' => 'events#explanation', as: 'explanation'

  #mail
  post 'mail_movement/:movement_id' => 'mail#mail_movement', as: 'mail_movement'
  post 'mail_event/:event_id/:movement_id' => 'mail#mail_event', as: 'mail_event'

  #export CSV
  get 'export_csv/:id' => 'movements#export_csv', as: 'export_csv'

end
