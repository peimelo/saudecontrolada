Saudecontrolada::Application.routes.draw do
  root 'site#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  authenticated :user do
    mount DelayedJobWeb, at: Rails.application.secrets.delayed_job_web_path
  end

  resources :contatos, only: [:index, :new, :create]
  get 'dashboard/index'

  resources :exames, except: :show do
    collection do
      get 'autocomplete'
    end
  end

  resources :pesos, except: :show
  resources :referencias, except: :show
  resources :resultados
  #TODO: ver a melhor rota
  get 'resultados/new(/:exame_nome)' => 'resultados#new', as: 'new_resultado_exame'
  resources :unidades, except: :show
  resources :users, only: :index
  post 'versions/:id/revert' => 'versions#revert', as: 'revert_version'

  # API
  namespace :api, defaults: { format: :json } do
    resources :pesos, only: [:index]
  end
end
