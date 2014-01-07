Ffstrike::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks", :registrations => "users", :invitations => 'users/invitations'  }

  root 'home#index'

  get 'rallies' => 'rallies#search'  

  #home
  get 'about' => 'home#about',  as: 'about'

  #movements
  resources :movements do
    resources :rallies
    resources :tasks
  end

  resources :rallies do
    resources :attendees
  end

  #mail
  post 'mail_movement/:movement_id' => 'mail#mail_movement', as: 'mail_movement'

  #post 'mail_rally' => 'mail#mail_rally'
  post 'mail_rally/:rally_id/:movement_id' => 'mail#mail_rally', as: 'mail_rally'



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
