ENV['RAILS_ENV'] = 'test'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.example_status_persistence_file_path = 'spec/examples.txt'

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end

  # N + 1で落とす
  # よくわからない落ちかたするのでコメントアウト
  # if Bullet.enable?
  #   config.before(:each) do
  #     Bullet.start_request
  #   end

  #   config.after(:each) do
  #     Bullet.perform_out_of_channel_notifications if Bullet.notification?
  #     Bullet.end_request
  #   end
  # end
end
