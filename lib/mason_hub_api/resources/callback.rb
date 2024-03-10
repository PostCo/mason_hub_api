# frozen_string_literal: true

module MasonHubAPI
  class CallbackResource < Resource
    def all(message_type: "all")
      response = get_request("callbacks", params: { message_type: message_type })

      response.body.map { |attributes| Callback.new(attributes) }
    end

    def create(attributes)
      # accept either a single hash or an array of hashes
      attributes = [attributes] if attributes.is_a?(Hash)

      response = Response.new(post_request("callbacks", body: attributes).body)
      response.results = response.results.map { |callback| Callback.new(callback) }
      response
    end

    #
    # Delete the registered callbacks
    #
    # @param [Array] callback_ids The callback ids to delete
    #
    # @return [Response] String response
    #
    def delete(callback_ids)
      callback_ids = [callback_ids] if callback_ids.is_a?(String)
      raise ArgumentError, "callback_ids must be an array or string" unless callback_ids.is_a?(Array)

      delete_request("callbacks", body: callback_ids).body
    end
  end
end
