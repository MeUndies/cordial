# Cordial

[![Gem Version](https://badge.fury.io/rb/cordial.svg)](https://badge.fury.io/rb/cordial)
[![Maintainability](https://api.codeclimate.com/v1/badges/a53de2aaf1773c8cfb06/maintainability)](https://codeclimate.com/github/MeUndies/cordial/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/a53de2aaf1773c8cfb06/test_coverage)](https://codeclimate.com/github/MeUndies/cordial/test_coverage)

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

To get started you're going to need to get a Cordial api key.

After checking out the repo, run `bin/setup` to install dependencies. Then
update your `.env` files with your api key. Then, run `rake spec` to run the
tests. You can also run `bin/console` for an interactive prompt that will allow
you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To
release a new version, update the version number in `version.rb`, and then run
`bundle exec rake release`, which will create a git tag for the version, push
git commits and tags, and push the `.gem` file to
[rubygems.org](https://rubygems.org).

## Tests

Once you've setup your environment you can run the tests with `rake spec`. In
order to re-record VCR cassettes you'll want to make sure you have the following
env var set as follows: `VCR=all`.

## Contributing

Bug reports and pull requests are welcome!
