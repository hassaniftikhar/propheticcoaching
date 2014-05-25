Propheticcoaching::Application.routes.draw do

  resources :contact_requests

  # resources :featured_products

  resources :featured_products , :only => [:index, :show] do
    member do
      get 'image'
    end
  end

  # resources :best_features
  resources :best_features , :only => [:index, :show] do
    member do
      get 'image'
    end
  end
  resources :benefits , :only => [:index, :show]

  resources :exercises
  resources :activities
  # get "index", to: "info/index"
  # get "about", to: 'info#about'
  # get "features", to: "info/features"
  # get "contact", to: "info/contact"

  get "info/index"
  get "info/about"
  get "info/features"
  # post 'info/contact', to: 'info#send_message'
  # get "time_slots/new"
  # get "time_slots/create"

  resources :questions

  # resources :email_histories

  # resources :accomplishments

  # resources :tasks

  get "dashboard/index"
   #get "dashboad/index"
   #get "dashboard" => "dashboard#index"
   #get '/dashboard', to: 'dashboard#index'
   #match '/dashboard', to: 'dashboard#index', via: :get
   #root :to => 'dashboard#index'
   root :to => 'info#index'
   #resource :dashboard , :only => [:index]
  #devise_for :users
  #devise_for :users, controllers: {registrations: "users/registrations"}
  devise_for :users, :controllers => { :registrations => "users/registrations" }
  ActiveAdmin.routes(self)

  #resources :chats do
  #  collection do
  #    get :talk
  #  end
  #end

  resources :ebooks do
    collection do
      get 'search'
    end
    member do
      get 'pdf'
    end
  end

  resources :mentees do
    resources :events do
      collection do
        get :get_events
      end
    end
    resources :google_events #, :only => [:new, :create, :edit, :update]
  end

  resources :users, :only => [:index, :show] do
    resources :mentees do
      resources :goals
      resources :comments
      resources :tasks
      resources :accomplishments
      resources :email_histories

      member do
        post :save
      end

    end
    resources :events do
      collection do
        get :get_events
      end
    end
    resources :google_events #, :only => [:new, :create]
  end

  resources :events, :only => [:index, :edit, :update, :destroy] do
    collection do
      get :get_events
    end
    member do
      post :move
      post :resize
    end
    resources :time_slots
  end
  
  # root :to => 'dashboard#index'
  resque_constraint = lambda do |request|
    # request.env['warden'].authenticate? and request.env['warden'].user.admin?
    request.env['warden'].authenticate? and request.env['warden'].user.has_role?(:admin)
  end

  constraints resque_constraint do
    mount Resque::Server, :at => "/admin/resque"
  end

  # mount Resque::Server, :at => "/resque"
  # authenticate do
  #   mount Resque::Server.new, at: '/resque'
  # end  

  # authenticate :admin do
  #   mount Resque::Server, :at => "/resque"
  # end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the  root of your site routed with "root"
  #root 'coaches#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :documents

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
