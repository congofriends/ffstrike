Ffstrike::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users", :invitations => 'users/invitations'  }

  root 'static_pages#index'

  get 'events' => 'events#search'  

  #home
  get 'about' => 'static_pages#about',  as: 'about'

  #movements
  resources :movements do
    get 'my_movements' => 'movements#user_movements', on: :collection, as: 'user'
    get 'movement_dashboard' => 'movements#dashboard', on: :member, as: 'dashboard'
    resources :events, shallow: true
    resources :tasks do
      get 'assign' => 'assignments#assign', on: :member, as: 'assign'
    end
  end
  get 'visitor/:id' => 'movements#visitor', as: 'visitor' 

  resources :events do
    resources :tasks do
      get 'assign' => 'assignments#assign', on: :member, as: 'assign'
    end
    resources :attendees
  end

  #mail
  post 'mail_movement/:movement_id' => 'mail#mail_movement', as: 'mail_movement'
  post 'mail_event/:event_id/:movement_id' => 'mail#mail_event', as: 'mail_event'

  #export CSV
  get 'export_csv/:id' => 'movements#export_csv', as: 'export_csv'


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
