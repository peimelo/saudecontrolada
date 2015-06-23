Saudecontrolada::Application.routes.draw do
  root 'site#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  authenticated :user do
    mount DelayedJobWeb, at: Rails.application.secrets.delayed_job_web_path
  end

  resources :exames, except: :show do
    collection do
      get 'autocomplete'
    end
  end

  #TODO: ver a melhor rota
  get 'resultados/new(/:exame_nome)' => 'resultados#new', as: 'new_resultado_exame'

  post 'versions/:id/revert' => 'versions#revert', as: 'revert_version'

  resources :contatos, only: [:index, :new, :create]
  resources :dashboard, only: :index
  resources :pesos, except: :show
  resources :referencias, except: :show
  resources :resultados
  resources :unidades, except: :show
  resources :users, only: :index
end
