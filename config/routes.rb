require 'api_constraints'

Rails.application.routes.draw do
  namespace :api,
            defaults: { format: :json } do

    scope module: :v1,
          constraints: ApiConstraints.new(version: 1, default: true) do

      resources :alimentations,    only: [:create, :destroy, :index, :show, :update] do
        resources :alimentations_foods,  only: [:create, :destroy, :index, :show, :update]
      end
      resources :confirmations,    only: [:create, :update]
      resources :contacts,         only: [:create]
      resources :dashboards,       only: [:index]
      resources :exams,            only: [:create, :destroy, :index, :show, :update] do
        resources :valores,  only: [:create, :destroy, :update]
      end
      resources :exams_graphics,   only: [:index, :show]
      resources :foods,            only: [:index]
      resources :meals,            only: [:index]
      resources :passwords,        only: [:create, :update]
      resources :references,       only: [:create, :destroy, :index, :show, :update]
      resources :results,          only: [:create, :destroy, :index, :show, :update] do
        resources :exams_results,  only: [:create, :destroy, :index, :show, :update]
      end
      resources :sessions,         only: [:create]
      resources :units,            only: [:create, :destroy, :index, :show, :update]
      resources :users,            only: [:create, :destroy, :index, :show, :update]
      resources :weights,          only: [:create, :destroy, :index, :show, :update]
    end
  end
end
