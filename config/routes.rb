Saudecontrolada::Application.routes.draw do
  get 'dashboard/index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root 'site#index'

  resources :acoes, except: :show
  resources :contatos, only: [:index, :new, :create]
  resources :controladores, except: :show
  resources :dashboard, only: :index
  resources :erros, except: [:new, :create]
  resources :pesos
  resources :recursos, except: :show
  resources :recursos_categorias, except: :show
  resources :users, except: :show
end
