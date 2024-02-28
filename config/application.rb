require_relative 'boot'

require 'rails/all'
#require 'file_column'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Fuga326
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.0

    config.i18n.default_locale = :ja
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.time_zone = "Tokyo"
    config.active_record.default_timezone = :local
    config.middleware.insert_before 0, Rack::Cors do
        allow do
            origins "http://localhost:3000", "https://speed.956.jp", "https://queen.956.jp"
            resource "*",
            headers: :any,
            methods: [:get, :post, :patch, :delete,  :options, :head]
        end
    end
  end
end
