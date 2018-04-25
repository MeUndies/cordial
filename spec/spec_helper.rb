require "bundler/setup"

require "dotenv"
Dotenv.load('.env.test')

require "pry"
require "cordial"

Cordial.configure do |config|
  config.api_key = ENV['API_KEY']
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
