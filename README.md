# EmailWizard

Ruby integration for emailwizard

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'email_wizard'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install email_wizard

## Usage

### Config client

```ruby
client = EmailWizard::Client.new
client.config = EmailWizard::Config.new(
  api_key: 1,
  provider: :sendgrid,
  provider_credentials: {
    api_key: 2
  },
  from: 'no-reply@example.org'
)
```

You can set default project id instead of passing it on each call:

```ruby
    client.current_project_id = 1
```

### Fetch template

See https://docs.emailwizard.io/fetching_emails_api.html for details:

```ruby
client.fetch_template(template_name: 'hello', payload: {name: 'John Doe'})
```

### Send template

See https://docs.emailwizard.io/sending_emails_api.html for details:

```ruby
client.send_template(template_name: 'hello', subject: 'Hello!',
                     recipients: ['user@example.com'], payload: {name: 'John Doe'})
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/email_wizard.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
