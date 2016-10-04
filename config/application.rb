require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SimulationFrontend
  class Application < Rails::Application

    # Always log everything to standard out, we will do this in prod on
    # heroku anyway (see rails-12-factor gem) so might as well do it
    # in development too
    config.logger = ActiveSupport::Logger.new(STDOUT)

    # Add lib to the autoload path
    config.eager_load_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('lib')

    # Set the default explicitly to be english
    config.i18n.default_locale = :en

    # Don't include all helpers all the time
    config.action_controller.include_all_helpers = false

    # Add fonts to asset pipeline
    config.assets.paths << Rails.root.join('assets', 'fonts')

    # Disable most generators for the test
    config.generators do |g|
      # Use rspec when generating tests
      g.test_framework :rspec

      # Don't generate CSS or JS files
      g.stylesheets false
      g.javascripts false
      g.jbuilder false
    end

  end
end
