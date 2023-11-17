# frozen_string_literal: true

require_relative "mason_hub_api/version"

module MasonHubAPI
  autoload :Client, "mason_hub_api/client"
  autoload :Error, "mason_hub_api/error"
  autoload :Object, "mason_hub_api/object"
  autoload :Resource, "mason_hub_api/resource"

  autoload :Callback, "mason_hub_api/objects/callback"
  autoload :Response, "mason_hub_api/objects/response"
  autoload :Return, "mason_hub_api/objects/return"

  autoload :CallbackResource, "mason_hub_api/resources/callback"
  autoload :ReturnResource, "mason_hub_api/resources/return"
end
