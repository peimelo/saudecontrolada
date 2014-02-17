require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Saudecontrolada
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.autoload_paths += %W(#{config.root}/lib)
    
    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Brasilia'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = 'pt-BR'

    # Faz com que a asset pipeline encontre os arquivos adicionados em vendor tendo uma sub-pasta
    # para cada lib, permitindo assim que as imagens, css e js daquela lib fiquem centralizadas
    # para facilitar futuras atualizações.
    # config.assets.paths += Dir["#{Rails.root}/vendor/asset-libs/**/"].sort_by { |dir| -dir.size }
    # config.assets.paths << Rails.root.join("app", "assets", "fonts")

    # don't generate RSpec tests for views and helpers
    config.generators do |g|
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.helper = false
      g.javascripts = false
      g.stylesheets = false
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
    end
  end
end
