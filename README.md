# MasonHubAPI

This is an API wrapper gem for MasonHubAPI API.

## Installation

Install the gem and add to the application's Gemfile by executing:

    $ bundle add mason_hub_api

If bundler is not being used to manage dependencies, install the gem by executing:

    $ gem install mason_hub_api

## Usage

A client must be initialized with MasonHub's account slug (account name) and bearer token for the user's account.

```ruby
client = MasonHubAPI::Client.new(url_slug: ENV["MASONHUB_SLUG"], bearer_token: ENV["MASONHUB_SANDBOX_TOKEN"])

# for sandbox environment
client = MasonHubAPI::Client.new(url_slug: ENV["MASONHUB_SLUG"], bearer_token: ENV["MASONHUB_SANDBOX_TOKEN"], sandbox: true)
```

The URL prefix for the API is `https://app.masonhub.co/{urlSlug}/api/{basePath}` for production and `https://sandbox.masonhub.co/{urlSlug}/api/{basePath}` for sandbox environment.
The `basePath` defaults to `v1` and can be changed by passing `base_path` to the client.

```ruby
client = MasonHubAPI::Client.new(url_slug: ENV["MASONHUB_SLUG"], bearer_token: ENV["MASONHUB_SANDBOX_TOKEN"], base_path: "v2")
```

### Callback

#### Get callbacks

```ruby
client.callback.all
```

To specify the message type, pass `message_type` to the method.

```ruby
client.callback.all(message_type: "orderEvent")
```

#### Create callback

```ruby
# for one callback
params = {
    url: "https://example.com/callback",
    message_type: "orderEvent",
    api_version: "2.0"
}

# for many callbacks
params = [
    {
        url: "https://example1.com/callback",
        message_type: "orderEvent",
        api_version: "2.0"
    },
    {
        url: "https://example2.com/callback",
        message_type: "orderEvent",
        api_version: "2.0"
    }
]

client.callback.create(params)
```

### Return

#### Get returns

```ruby
client.return.all
```

To specify the search, pass the search parameters to the method.

```ruby
client.return.all(id: [1, 2, 3], status: "all", ...)
```

#### Create return

```ruby
params = {
    customer_identifier: "123",
    manifest_id: "234",
    ...
}

# for more than one return
params = [
    {
        customer_identifier: "123",
        manifest_id: "234",
        ...
    },
    {
        customer_identifier: "456",
        manifest_id: "567",
        ...
    }
]

client.return.create(params)
```

#### Update return

```ruby
params = {
    customer_identifier: "123",
    manifest_id: "234",
    ...
}

# for more than one return
params = [
    {
        customer_identifier: "123",
        manifest_id: "234",
        ...
    },
    {
        customer_identifier: "456",
        manifest_id: "567",
        ...
    }
]

client.return.update(params)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/PostCo/mason_hub_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/PostCo/mason_hub_api/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the MasonHubAPI project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/PostCo/mason_hub_api/blob/main/CODE_OF_CONDUCT.md).
