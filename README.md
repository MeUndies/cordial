# Cordial

[ ![Codeship Status for MeUndies/cordial](https://app.codeship.com/projects/ecb6fbe0-2a65-0136-d9ce-769c4cc8653c/status?branch=master)](https://app.codeship.com/projects/287555)
[![Gem Version](https://badge.fury.io/rb/cordial.svg)](https://badge.fury.io/rb/cordial)
[![Maintainability](https://api.codeclimate.com/v1/badges/52901e63f4f656dc1cfe/maintainability)](https://codeclimate.com/repos/5ae0efa43c3ef10298000760/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/52901e63f4f656dc1cfe/test_coverage)](https://codeclimate.com/repos/5ae0efa43c3ef10298000760/test_coverage)

A ruby gem to interact with the [Cordial API](https://api.cordial.io/docs/v1/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cordial'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install cordial

```ruby
Cordial.configure do |config|
  config.api_key = 'your-api-key'
end
```

## Usage

```ruby
Cordial::Contact.create(email: 'hello@world')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome!
