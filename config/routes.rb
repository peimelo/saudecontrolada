Saudecontrolada::Application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  root 'site#index'

  resources :acoes, except: :show
  resources :contatos, only: [:index, :new, :create]
  resources :controladores, except: :show
  resources :erros, except: [:new, :create]
  resources :pesos
  resources :recursos, except: :show
  resources :recursos_categorias, except: :show
  resources :users, except: :show
end
