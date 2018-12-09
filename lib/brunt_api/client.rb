require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'
require 'json'
require 'brunt_api/error'

module BruntAPI
  class Client
    def initialize
      @conn = Faraday.new do |faraday|
        faraday.request :json
        faraday.use :cookie_jar
        faraday.adapter Faraday.default_adapter
      end
    end

    def login(username, password)
      res = @conn.post do |req|
        req.url 'https://sky.brunt.co/session'
        req.body = { ID: username, PASS: password }
      end

      if res.success?
        JSON.parse(res.body)
      else
        handle_failed_response(res, 'Failed to login.')
      end
    end

    def get_things
      res = @conn.get do |req|
        req.url 'https://sky.brunt.co/thing'
      end

      if res.success?
        JSON.parse(res.body)
      else
        handle_failed_response(res, 'Failed to get things.')
      end
    end

    def get_state(thing_uri)
      res = @conn.get do |req|
        req.url 'https://thing.brunt.co/thing' + thing_uri
      end

      if res.success?
        JSON.parse(res.body)
      else
        handle_failed_response(res, 'Failed to get state of thing.')
      end
    end

    def set_position(thing_uri, position)
      unless position.kind_of?(Numeric)
        raise ArgumentError, 'Position must be Numeric.'
      end
      if position.kind_of?(Complex)
        raise ArgumentError, 'Position must not be Complex.'
      end
      if position < 0 or position > 100
        raise ArgumentError, 'Position must be in range (0.0..100.0).'
      end

      res = @conn.put do |req|
        req.url 'https://thing.brunt.co/thing' + thing_uri
        req.body = { requestPosition: position.to_f.to_s }
      end

      if res.success?
        begin
          JSON.parse(res.body)
        rescue
          'success'
        end
      else
        handle_failed_response(res, 'Failed to set position of thing.')
      end
    end

    
    private
    def handle_failed_response(res, default_message)
      case res.status
      when 401
        raise BruntAPI::UnauthorizedError
      when 403
        raise BruntAPI::ForbiddenError
      when 404
        raise BruntAPI::NotFoundError
      when 503
        raise BruntAPI::ServiceUnavailableError
      else
        raise BruntAPI::ClientError, default_message + " (API response status: #{res.status})"
      end
    end
  end
end
