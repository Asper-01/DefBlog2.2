require_relative "boot"
require 'friendly_id'
require "rails/all"

Bundler.require(*Rails.groups)

module DefBlog
  class Application < Rails::Application
    config.action_controller.raise_on_missing_callback_actions = false if Rails.version >= "7.1.0"
    config.generators do |generate|
      generate.assets false
      generate.helper false
      generate.test_framework :test_unit, fixture: false
    end

    config.load_defaults 7.1

    config.autoload_lib(ignore: %w(assets tasks))

    config.action_controller.action_on_unpermitted_parameters = :raise

    # Configurations spécifiques pour Heroku
    config.serve_static_files = true
    config.assets.initialize_on_precompile = false
    config.assets.compile = true
    config.assets.digest = true
    config.assets.css_compressor = :scss

    config.cache_classes = true
    config.eager_load = true
    config.i18n.default_locale = :fr
    config.log_level = :info
  end
end
