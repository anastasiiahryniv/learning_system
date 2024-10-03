require 'simplecov'
SimpleCov.start
SimpleCov.command_name 'Unit Tests'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'factory_bot'
require 'faker'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.

  # Add more helper methods to be used by all tests here...
end
