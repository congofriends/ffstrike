Ffstrike::Application.routes.draw do
  # RailsAdmin
  mount RailsAdmin::Engine => '/admin', :as => 'rails_admin'

  # Devise - Authentication
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  # Landing/Home page
  root 'home#start'
  get 'home/start' => 'home#start'

  # Teams
  resources :teams
  get 'teams/:id/invite' => 'teams#invite', :as => 'invite_team'
  get 'teams/:id/join' => 'teams#join', :as => 'join_team'
  get 'teams/:id/apply/:role' => 'teams#apply', :as => 'apply_team'

  post 'teams/:id/role_application' => 'teams#create_role_application', :as => 'new_role_application'
  get 'teams/:id/role_application/:role_application_id' => 'teams#view_role_application', :as => 'view_role_application'
  post 'teams/:id/role_application/:role_application_id/:status' => 'teams#review_role_application', :as => 'review_role_application'

  get 'teams/:id/wait' => 'teams#wait', :as => 'wait_team'

  # Tasks
  post 'tasks/:team_id/:role_name/:task_id' => 'tasks#update'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
