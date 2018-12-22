require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Pankara
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.autoload_paths << Rails.root.join('lib')
    config.autoload_paths << Rails.root.join('lib', 'constants')
    config.autoload_paths << Rails.root.join('lib', 'core_ext', '*.rb')
    config.autoload_paths << Rails.root.join('app', 'modules')

    Dir[Rails.root.join('lib', 'core_ext', '*.rb')].each { |l| require l }

    config.generators do |g|
      g.javascripts false
      g.stylesheets false
      g.helper false
      g.test_framework :rspec,
                       fixture: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: true
    end
  end
end
