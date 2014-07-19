Saudecontrolada::Application.routes.draw do
  root 'site#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  # TODO: tentar validar se o user eh admin
  authenticated :user do
    mount DelayedJobWeb, at: '/jobs'
  end

  # resources :acoes, except: :show
  resources :contatos, only: [:index, :new, :create]
  # resources :controladores, except: :show
  # resources :dashboard, only: :index
  get 'dashboard/index'
  resources :erros, except: [:new, :create]
  resources :pesos, except: :show
  # resources :recursos, except: :show
  # resources :recursos_categorias, except: :show
  resources :users, only: :index
end
