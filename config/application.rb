# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'
require 'active_storage'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module InquisitorBackend
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: %i[get post options]
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end

  begin
    SECRETS = YAML.load_file("#{Rails.root}/config/secrets.yml")[Rails.env].symbolize_keys
  rescue StandardError => _e
    SECRETS = { pepipost_api_key: '', pepipost_url: '' }.freeze
  end

  begin
    ::S3_CREDENTIALS = YAML.load_file("#{Rails.root}/config/aws.yml")[Rails.env].symbolize_keys
  rescue StandardError => _e
    ::S3_CREDENTIALS = { access_key_id: '', secret_access_key: '', s3_region: '', bucket: '' }.freeze
  end
end
