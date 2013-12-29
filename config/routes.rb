RiakThreadedForum::Application.routes.draw do
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    get 'logout' => :destroy
  end
  get "welcome/index"
  get "home" => "user_home#index"
  get "user_home/index"

  controller :forums do
    get 'forums/:id/discussions' => :show  # To avoid error when URL chopping
  end

  resources :discussions do
    resources :forum_posts
  end
  
  resources :forums do
    resources :discussions, only: [:show, :new, :create]
  end
  
  
  controller :forum_posts do
    get 'forums/:forum_key/discussions/:discussion_key/reply' => :new_reply_discussion
    get 'forums/:forum_key/discussions/:discussion_key/reply_to/:reply_to_post' => :new_reply_post
    post 'forums/:forum_key/discussions/:discussion_key' => :create
    get 'forums/:forum_key/discussions/:discussion_id/posts/:id' => :show
    post 'forum_posts' => :create
  end
  
  resources :forum_posts
  resources :users
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

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
