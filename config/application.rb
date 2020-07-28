require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "active_storage/engine"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_mailbox/engine"
require "action_text/engine"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Chomper
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource(
          '*',
          headers: :any,
          expose: ["Authorization"],
          methods: [:get, :patch, :put, :delete, :post, :options,:show]
        )
      end
    end
    config.api_only = true
    config.action_mailer.smtp_settings = {
      address: ENV["MAIL_HOST"],
      port: ENV["MAIL_PORT"],
      domain: ENV["MAIL_HOST"],
      authentication: "plain",
      enable_starttls_auto: true,
      user_name: ENV["MAIL_USERNAME"],
      password:ENV["MAIL_PASSWORD"]
    }
  end
end
