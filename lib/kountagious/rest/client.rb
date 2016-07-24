require 'oauth2'
require 'faraday_middleware'

module Kountagious
  module REST
    class Client
      def initialize(options={})
        @redirect_uri         = options[:redirect_uri]
        @consumer             = options[:consumer] || {key: Kountagious.client_id, secret:Kountagious.client_secret}
        @access_token         = options[:access_token] || Kountagious.client_token
        @refresh_token        = options[:refresh_token] || Kountagious.client_refresh_token
        @client               = OAuth2::Client.new(@consumer[:key], @consumer[:secret], {
          site: Kountagious::SITE_URI,
          authorize_url: Kountagious::AUTHORIZATION_URI,
          token_url: Kountagious::TOKEN_URI
        }) do |faraday|
          faraday.request :json
          faraday.use Faraday::Request::UrlEncoded
          faraday.use Faraday::Response::Logger if Kountagious.enable_logging
          faraday.adapter Faraday.default_adapter
        end
      end

      def perform(request_method, url_hash, options={})

        scope = url_hash.delete(:scope) || :companies

        url_hash = scoped_url_hash(scope).merge! url_hash

        begin
            response = oauth_connection.request(request_method, "#{path_from_hash(url_hash)}.#{FORMAT.to_s}", options)
        rescue Exception => e
            if !e.message.nil? && (e.message.include?('The access token provided has expired') || e.message.include?('expired') || e.message.include?('invalid'))
                @auth_connection = refreshed_token
                retry
            end

            raise Kountagious::Errors::RequestError.new(response.nil? ? 'Unknown Status' : response.status)
        end

        unless response
            raise Kountagious::Errors::RequestError.new('Unknown Status')
        end

        response.parsed
      end

      def get(url_hash, options={})
        perform(:get, url_hash, options)
      end

      def put!(url_hash, options={})
        perform(:put, url_hash, options)
      end

      def post!(url_hash, options={})
        perform(:post, url_hash, options)
      end

      def delete!(url_hash, options={})
        perform(:delete, url_hash, options)
      end

      private

      def path_from_hash(url_hash)
          url_hash.map{ |key, value| value ? "#{key}/#{value.to_s.gsub("-", "%2D")}" : "#{key}" }.join('/')
      end

      def scoped_url_hash(scope)
        prefix_url_hash = {
          companies: Kountagious.company_id
        }

        if scope == :sites
          prefix_url_hash[:sites] = Kountagious.site_id
        end

        prefix_url_hash
      end

      def oauth_connection
        if @refresh_token
          @auth_connection ||= OAuth2::AccessToken.new(@client, @access_token, {
            :refresh_token => @refresh_token
          }).refresh!
        else
          @auth_connection ||= OAuth2::AccessToken.new(@client, @access_token)
        end
      end

      def refreshed_token
          OAuth2::AccessToken.from_hash(@client, :refresh_token => @refresh_token).refresh!
      end

    end
  end
end
