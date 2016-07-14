require 'rspec'
require 'webmock/rspec'
require 'kountagious'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include Helpers

  config.before(:each) do

    stub_endpoints

    Kountagious.configure do |config|
      config.client_id = "123"
      config.client_secret = "secret"
      config.client_refresh_token = "refresh-token"
      config.company_id = "999"
      config.site_id = "246"
    end
  end

end
