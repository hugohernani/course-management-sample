require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CourseManagement
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.generators do |g|
      g.test_framework :rspec
      g.view_specs false
      g.helper_specs false
      g.assets false
      g.helper false
    end

    config.api_only = true

    config.cache_store = :redis_store, {
      expires_in: 90.minutes,
      namespace: 'course_management_application_test',
      host: 'localhost',
      port: 6379,
      db: 0
    }

    config.middleware.use Rack::Attack
    config.active_job.queue_adapter = :sidekiq
  end
end
