# frozen_string_literal: true

require "active_support/core_ext/string"

module MasonHubAPI
  class Resource
    attr_reader :client

    def initialize(client)
      @client = client
    end

    def get_request(url, params: {}, headers: {})
      handle_response client.connection.get(url, params, headers)
    end

    def post_request(url, body:, headers: {})
      handle_response client.connection.post(url, parse_body(body), headers)
    end

    def put_request(url, body:, headers: {})
      handle_response client.connection.put(url, parse_body(body), headers)
    end

    def delete_request(url, body: {}, headers: {})
      response = client.connection.delete(url) do |request|
        request.body = parse_body(body)
        request.headers = request.headers.merge(headers)
      end

      handle_response response
    end

    private

    def handle_response(response)
      error_message = response.body

      case response.status
      when 400
        raise Error, "A bad request or a validation exception has occurred. #{error_message}"
      when 401
        raise Error, "Invalid authorization credentials. #{error_message}"
      when 403
        raise Error, "Connection doesn't have permission to access the resource. #{error_message}"
      when 404
        raise Error, "The resource you have specified cannot be found. #{error_message}"
      when 429
        raise Error, "The API rate limit for your application has been exceeded. #{error_message}"
      when 500
        raise Error,
              "An unhandled error with the server. Contact the MasonHub team if problems persist. #{error_message}"
      when 503
        raise Error,
              "API is currently unavailable – typically due to a scheduled outage – try again soon. #{error_message}"
      end

      response
    end

    def parse_body(params)
      if params.is_a?(Array)
        params.map { |value| parse_body(value) }
      elsif params.is_a?(Hash)
        params.deep_transform_keys { |key| key.to_s.underscore }
      end
    end

    def parse_response(response)
      response.body.deep_transform_keys { |key| key.to_s.underscore }
    end
  end
end
