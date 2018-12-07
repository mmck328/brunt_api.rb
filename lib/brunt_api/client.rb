require 'faraday'
require 'faraday_middleware'
require 'faraday-cookie_jar'
require 'json'

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
        puts 'Failed to login.'
      end
    end

    def get_things
      res = @conn.get do |req|
        req.url 'https://sky.brunt.co/thing'
      end

      if res.success?
        JSON.parse(res.body)
      else
        case res.status
        when 401
          puts 'Unauthorized or authorization expired. Login and retry.'
        else
          puts 'Failed to get things.'
        end
      end
    end

    def get_state(thing_uri)
      res = @conn.get do |req|
        req.url 'https://thing.brunt.co/thing' + thing_uri
      end

      if res.success?
        JSON.parse(res.body)
      else
        case res.status
        when 401
          puts 'Unauthorized or authorization expired. Login and retry.'
        else
          puts 'Failed to get state of thing.'
        end
      end
    end

    def set_position(thing_uri, position)
      unless position.kind_of?(Numeric)
        puts ':position must be Numeric'
        return nil
      end
      if position < 0 or position > 100
        puts ':position must be in range (0.0..100.0)'
        return nil
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
        case res.status
        when 401
          puts 'Unauthorized or authorization expired. Login and retry.'
        else
          puts 'Failed to set position of thing.'
        end
      end
    end
  end
end
