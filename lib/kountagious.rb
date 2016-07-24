require_relative "kountagious/version"
require_relative "kountagious/errors"
require_relative "kountagious/core_ext/array/extract_options"
require_relative "kountagious/core_ext/module/attribute_accessors"
require_relative "kountagious/rest/client"

module Kountagious
  AUTHORIZATION_URI = "https://my.kounta.com/authorize"
	TOKEN_URI = "https://api.kounta.com/v1/token.json"
	SITE_URI = "https://api.kounta.com/v1/"
	FORMAT = :json

  mattr_accessor :client_id, :client_secret, :client_refresh_token,
                 :company_id, :site_id, :client_token, :enable_logging

  @@enable_logging = false

  def self.root
    File.expand_path('../..', __FILE__)
  end

  def self.configure
		yield self
	end
end
