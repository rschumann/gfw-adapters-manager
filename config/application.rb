require File.expand_path('../boot', __FILE__)

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GfwAdaptersManager
  class Application < Rails::Application
    config.autoload_paths += Dir[Rails.root.join('api', 'app', 'controllers', 'concerns')]
    config.autoload_paths += Dir[Rails.root.join('app', 'models', 'users')]

    config.generators do |g|
      g.test_framework  :rspec
      g.view_specs      false
      g.helper_specs    false
      g.factory_girl    false
      g.template_engine :slim
      g.stylesheets     false
      g.javascripts     false
      g.helper          false
    end
  end
end
