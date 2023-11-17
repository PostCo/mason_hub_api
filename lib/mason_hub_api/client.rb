require 'faraday'

module MasonHubAPI
  class Client
    attr_reader :url_slug, :base_path, :bearer_token, :adapter, :sandbox
    
    def initialize(url_slug:, base_path: "v1", bearer_token:, adapter: Faraday.default_adapter, sandbox: false)
      @url_slug = url_slug
      @base_path = base_path
      @bearer_token = bearer_token
      @adapter = adapter
      @sandbox = sandbox
    end
    
    def connection
      @connection ||= Faraday.new do |conn|
        conn.url_prefix = url_prefix
        conn.headers['Authorization'] = "Bearer #{bearer_token}"
        conn.headers['Content-Type'] = "application/json"
        conn.request :json
        conn.response :json, content_type: "application/json"
        conn.adapter adapter
      end
    end
    
    def callback
      @callbacks ||= CallbackResource.new(self)
    end

    def return
      @returns ||= ReturnResource.new(self)
    end
    
    private
    
    def url_prefix
      subdomain = sandbox ? "sandbox" : "app"
      
      # https://app.masonhub.co/{urlSlug}/api/{basePath}
      # https://sandbox.masonhub.co/{urlSlug}/api/{basePath}
      "https://#{subdomain}.masonhub.co/#{url_slug}/api/#{base_path}"
    end
  end
end