# frozen_string_literal: true

module MasonHubAPI
  class CallbackResource < Resource
    def create(attributes)
      # accept either a single hash or an array of hashes
      attributes = [attributes] if attributes.is_a?(Hash)

      response = Response.new(post_request("callbacks", body: attributes).body)
      response.results = response.results.map { |callback| Callback.new(callback) }
      response
    end

    def all(message_type: "all")
      response = get_request("callbacks", params: { message_type: message_type })

      response.body.map { |attributes| Callback.new(attributes) }
    end
  end
end
