Ffstrike::Application.routes.draw do
  # RailsAdmin
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # Devise - Authentication
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users" }
  devise_scope :users do
    resources :users
  end

  # Landing/Home page
  root 'home#start'
  get 'home/start' => 'home#start'
  get 'home/faq' => 'home#faq', :as => 'faq'

  # Teams
  resources :teams
  get 'teams/:id/invite' => 'teams#invite', :as => 'invite_team'
  get 'teams/:id/join' => 'teams#join', :as => 'join_team'
  get 'teams/:id/apply/:role' => 'teams#apply', :as => 'apply_team'
  post 'teams/find' => 'teams#index', :as => 'find_teams'
  get 'teams/:id/reassign/:role_application_id' => 'teams#reassign', :as => 'reassign'

  # Roles
  post 'teams/:id/role_application' => 'teams#create_role_application', :as => 'new_role_application'
  get 'teams/:id/role_application/:role_application_id' => 'teams#view_role_application', :as => 'view_role_application'
  post 'teams/:id/role_application/:role_application_id/:status' => 'teams#review_role_application', :as => 'review_role_application'
  delete 'teams/:id/role_application/:role_application_id' => 'teams#cancel_role_application', :as => 'cancel_role_application'
  get 'teams/:id/wait' => 'teams#wait', :as => 'wait_team'
  get 'teams/:id/reassign_team_member/:role_application_id/' => 'teams#reassign_team_member', :as => 'reassign_team_member'

  # Tasks
  post 'tasks/:team_id/:role_name/:task_id' => 'tasks#update'

  # Leaflets
  get 'leaflets/' => 'leaflets#index'
  get 'leaflets/download' => 'leaflets#download', :as => 'download_leaflet'
end
