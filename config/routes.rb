Saudecontrolada::Application.routes.draw do
  root 'site#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  # TODO: tentar validar se o user eh admin
  authenticated :user do
    mount DelayedJobWeb, at: '/qazplm1029'
  end

  resources :acoes, except: :show
  resources :contatos, only: [:index, :new, :create]
  resources :controladores, except: :show
  get 'dashboard/index'
  resources :erros, except: [:new, :create]

  resources :exames, except: :show do
    collection do
      get 'autocomplete'
    end
  end

  resources :pesos, except: :show
  resources :referencias, except: :show
  resources :recursos, except: :show
  resources :recursos_categorias, except: :show
  resources :resultados#, except: :show
  resources :unidades, except: :show
  resources :users, only: :index
  post 'versions/:id/revert' => 'versions#revert', as: 'revert_version'
end
