# frozen_string_literal: true
require 'tempfile'
require 'byebug'
require "rate_detector"
require "support/csv_file_generator"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
  config.include CsvFileGenerator

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
