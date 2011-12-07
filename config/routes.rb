GARS::Application.routes.draw do
  resources :users
  
  get 'applications/get_app'
  resources :applications

  get 'apply_yourselves/update_field'
  resources :apply_yourselves

  get 'official_test_scores/update_field'
  resources :official_test_scores

  get 'reviews/edit_reviews'
  post "reviews/post_review"
  get "reviews/update_review"
  resources :reviews
 
  post "applications/make_decision"  

  post 'assign_review/auto_assign'
  post 'assign_review/assign_reviewers' 

  get "home/index"
  post "home/login"
  get "home/logout"

  get "view_table/view"
  get "home/round"
  get "home/upload"
  get "home/reviews"

  post "view_table/add_remove_fields"

  post "upload/file"
  post "home/search"
  post "assign_review/assign"
  post "home/filter_user"

  get "reviews/filter"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
  root :to => 'home#index'
  
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
