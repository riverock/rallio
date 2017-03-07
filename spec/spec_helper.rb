require "simplecov"
SimpleCov.start do
  add_filter 'spec'
end

require "bundler/setup"
require "rallio"
require "rspec/its"

require_relative "fixtures/response_fixtures"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.include ResponseFixtures
end
