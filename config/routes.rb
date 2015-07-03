Rails.application.routes.draw do
  root 'site#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  authenticated :user do
    mount DelayedJobWeb, at: Rails.application.secrets.delayed_job_web_path
  end

  #TODO: ver a melhor rota
  get 'resultados/new(/:exame_nome)' => 'resultados#new', as: 'new_resultado_exame'

  resources :contatos, only: [:index, :new, :create]
  resources :dashboard, only: :index
  resources :exames, except: :show
  resources :pesos, except: :show
  resources :referencias, except: :show
  resources :resultados
  resources :unidades, except: :show
  resources :users, only: :index

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
