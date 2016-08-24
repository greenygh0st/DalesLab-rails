Rails.application.routes.draw do

  get 'uploads/new'

  root 'blogs#index'
  get 'blogs/allposts' => 'blogs#admin_list'
  post 'blogs/create' => 'blogs#create'
  get 'blogs/new' => 'blogs#new'
  get 'blogs/:urllink' => 'blogs#show', as: :blog
  get 'blogs/:urllink/edit' => 'blogs#edit'
  patch 'blogs/:urllink/update' => 'blogs#update'

  #Portfolio
  get 'portfolio' => 'portfolio#index'
  get 'portfolio/new' => 'portfolio#new'
  post 'portfolio/create' => 'portfolio#create'
  get 'portfolio/:id/edit' => 'portfolio#edit'
  patch 'portfolio/:id/update' => 'portfolio#update'
  get 'portfolio/:id/destroy' => 'portfolio#destroy'

  #subscription routes
  get 'subscription/already_exists' => 'subscriptions#already_exists'
  post 'subscription/create' => 'subscriptions#create'
  get 'subscription/:verify/verify' => 'subscriptions#verify'
  get 'subscription/:verify/delete' => 'subscriptions#delete'

  #account routes
  get 'account/change_password' => 'account#change_password'
  post 'account/change_password' => 'account#update_password'
  get 'account/enable_tfa' => 'account#enable_tfa'
  post 'account/enable_tfa' => 'account#enable_tfa_post'
  get 'account/verify_tfa' => 'account#verify_tfa'
  post 'account/verify_tfa' => 'account#verify_tfa_post'
  post 'account/disable_tfa' => 'account#disable_tfa'


  #session routes
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  #static pages
  get 'about' => 'pages#about'
  get 'membership' => 'pages#membership'

  #error routes
  get '404' => 'pages#notfound'
  get 'secviolation' => 'pages#secviolation'

  #uploader routes
  get 'uploads/new' => 'uploads#new'
  get 'uploads/get_images' => 'uploads#get_images'
  resources :uploads

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
