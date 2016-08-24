require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FoodApp
  class Application < Rails::Application
    config.middleware.insert_before 0, "Rack::Cors", :debug => true, :logger => (-> { Rails.logger }) do
      allow do
        origins '*'

        resource '/cors',
                 :headers => :any,
                 :methods => [:post],
                 :credentials => true,
                 :max_age => 0

        resource '*',
                 :headers => :any,
                 :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
                 :methods => [:get, :post, :put, :patch, :delete, :options]
      end
    end

    # config.middleware.insert_before 0, "Rack::Cors" do
    #   allow do
    #     origins '*'
    #     resource '*',
    #              :headers => :any,
    #              :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
    #              :methods => [:get, :post, :put, :patch, :delete, :options]
    #   end
    # end
    config.active_record.raise_in_transactional_callbacks = true
    # config.api_only = false
    # config.assets.initialize_on_precompile = false
  end
end
