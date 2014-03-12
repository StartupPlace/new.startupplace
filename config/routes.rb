Startupplace::Application.routes.draw do

  root 'static_pages#home'
  get 'about' => 'static_pages#about'
  get 'ideastartup' => 'static_pages#ideastartup'
  get 'dashboard' => 'dashboard#index'

  namespace :dashboard do
    resources :news
    resources :users, :only => [:edit, :update]
  end

  resources :news, :only => [:index, :show]
  resources :tags, :only => [:show]

  mount Ckeditor::Engine => '/ckeditor'
  
  devise_for :users, :skip => [:sessions, :registrations, :passwords]
  as :user do
    get 'signup' => 'registrations#new', :as => :new_user_registration 
    post 'signup' => 'registrations#create', :as => :user_registration
    get 'account/cancel' => 'registrations#cancel', :as => :cancel_user_registration
    get 'account/edit' => 'registrations#edit', :as => :edit_user_registration
    put 'signup' => 'registrations#update'
    delete 'signup' => 'registrations#destroy'

    get 'signin' => 'devise/sessions#new', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    match 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session,
      :via => Devise.mappings[:user].sign_out_via
  end

  get 'account/:username', :to => 'accounts#show', :as => :account

  resources :sitemap, only: [:index]

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
