# frozen_string_literal: true

module MasonHubAPI
  class ReturnResource < Resource
    def create(attributes)
      # accept either a single hash or an array of hashes
      attributes = [attributes] if attributes.is_a?(Hash)

      Response.new(post_request("rmas", body: attributes).body)
    end

    def all(attributes = {})
      response = Response.new(get_request("rmas", params: attributes).body)
      response.data = response.data.map { |rma| Return.new(rma) }

      response
    end

    def update(attributes)
      # accept either a single hash or an array of hashes
      attributes = [attributes] if attributes.is_a?(Hash)

      Response.new(put_request("rmas", body: attributes).body)
    end

    def delete(customer_identifiers)
      customer_identifiers = [customer_identifiers] if customer_identifiers.is_a?(String)
      customer_identifiers = customer_identifiers.map { |customer_identifier| { customer_identifier: customer_identifier } }
      
      Response.new(delete_request("rmas", body: customer_identifiers).body)
    end
  end
end
