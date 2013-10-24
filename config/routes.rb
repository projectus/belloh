class Subdomain
  def self.matches?(request)
    return false unless (request.subdomain.present? && request.subdomain != "www")
    return false unless request.subdomain.size.between?(1,20)    
    return true
  end
end

Belloh::Application.routes.draw do

	constraints(Subdomain) do
	  get '/', to: 'virtual_hubs#show'
	  get 'edit', to: 'virtual_hubs#edit', as: 'edit_vhub'
	  patch 'update', to: 'virtual_hubs#update', as: 'update_vhub'
	end

  # You can have the root of your site routed with "root"
  root 'welcome#show'

  get "user/:id", to: "users#show", as: "user"
  resources :hub_posts, only: [:index,:create]
  resources :virtual_hubs, only: [:create]

  resources :posts, only: [:index,:create]

  devise_for :users, controllers: { registrations: 'users/registrations' }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get 'about', to: "information#about"
  get 'help', to: "information#help"
  get 'terms', to: "information#terms"
  get 'privacy', to: "information#privacy"
  get 'hubs', to: "information#hubs"
  get 'usage', to: "information#usage"

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
