# == Route Map
#
#                      Prefix Verb   URI Pattern                                 Controller#Action
# edit_api_account_activation GET    /api/account_activations/:id/edit(.:format) api/v1/account_activations#edit {:format=>:json}
#                   api_pesos GET    /api/pesos(.:format)                        api/v1/pesos#index {:format=>:json}
#                api_sessions POST   /api/sessions(.:format)                     api/v1/sessions#create {:format=>:json}
#                 api_session DELETE /api/sessions/:id(.:format)                 api/v1/sessions#destroy {:format=>:json}
#                   api_users GET    /api/users(.:format)                        api/v1/users#index {:format=>:json}
#                             POST   /api/users(.:format)                        api/v1/users#create {:format=>:json}
#                    api_user GET    /api/users/:id(.:format)                    api/v1/users#show {:format=>:json}
#                             PATCH  /api/users/:id(.:format)                    api/v1/users#update {:format=>:json}
#                             PUT    /api/users/:id(.:format)                    api/v1/users#update {:format=>:json}
#                             DELETE /api/users/:id(.:format)                    api/v1/users#destroy {:format=>:json}
#

require 'api_constraints'

Rails.application.routes.draw do
  namespace :api,
            defaults: { format: :json } do

    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do

      resources :confirmations, only: [:create, :update]
      resources :contacts,      only: [:create]
      resources :dashboards,    only: [:show]
      resources :passwords,     only: [:create, :update]
      resources :pesos,         only: [:create, :destroy, :index, :show, :update]
      resources :references,    only: [:create, :destroy, :index, :show, :update]
      resources :results,       only: [:create, :destroy, :index, :show, :update]
      resources :sessions,      only: [:create]
      resources :units,         only: [:create, :destroy, :index, :show, :update]
      resources :users,         only: [:create, :destroy, :index, :show, :update]
    end
  end
end
