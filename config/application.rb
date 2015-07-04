require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Saudecontrolada
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # -------------------------------------------
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
    config.action_mailer.default_url_options = { host: Rails.application.secrets.mailer_host }
    # para nao dar erro no Travis CI
    Rails.application.routes.default_url_options[:host] = Rails.application.secrets.mailer_host

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
