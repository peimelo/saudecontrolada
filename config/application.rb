require File.expand_path('../boot', __FILE__)

require 'rails/all'

Bundler.require(:default, Rails.env)

module Saudecontrolada
  class Application < Rails::Application
    # carrega um arquivo adicional que contem as senhas em variaveis de ambiente
    config.before_configuration do
      ENV_PATH = File.expand_path('../env.rb', __FILE__)
      require ENV_PATH if File.exists?(ENV_PATH)
    end

    config.autoload_paths += %W(#{config.root}/lib)

    config.time_zone = 'Brasilia'
    config.i18n.default_locale = 'pt-BR'
    config.i18n.enforce_available_locales = false

    # Devise
    #config.action_mailer.default_url_options = { host: Rails.application.secrets.mailer_host }
    config.action_mailer.default_url_options = { host: 'localhost:3000' }

    config.generators do |g|
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.helper = false
      g.helper_specs = false
      g.javascripts = false
      g.request_specs = false
      g.stylesheets = false
      g.test_framework :rspec, fixture: true
      g.view_specs = false
    end
  end
end
