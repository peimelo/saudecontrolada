require 'api_constraints'

Rails.application.routes.draw do
  namespace :api,
            defaults: { format: :json } do

    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do

      resources :confirmations,    only: [:create, :update]
      resources :contacts,         only: [:create]
      resources :dashboards,       only: [:show]
      resources :exams,            only: [:index]
      resources :passwords,        only: [:create, :update]
      resources :references,       only: [:create, :destroy, :index, :show, :update]
      resources :results,          only: [:create, :destroy, :index, :show, :update] do
        resources :exams_results,  only: [:create, :destroy, :index, :show, :update]
      end
      resources :results_graphics, only: [:index]
      resources :sessions,         only: [:create]
      resources :units,            only: [:create, :destroy, :index, :show, :update]
      resources :users,            only: [:create, :destroy, :index, :show, :update]
      resources :weights,          only: [:create, :destroy, :index, :show, :update]
    end
  end
end
