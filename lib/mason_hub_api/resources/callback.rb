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
    # @param [Array] message_types An array of message types to delete.
    # Available type: "skuInventoryChange", "orderEvent", "orderCancelResolution", "orderUpdateResolution", "rmaEvent", "inboundShipmentEvent", "snapshotReady"
    #
    # @return [Response] An array of deleted callbacks
    #
    def delete(message_types)
      message_types = [message_types] if message_types.is_a?(String)
      raise ArgumentError, "message_types must be an array or string" unless message_types.is_a?(Array)

      delete_request("callbacks", body: message_types).body
    end
  end
end
