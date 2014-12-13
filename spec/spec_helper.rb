ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  ActiveRecord::Migration.maintain_test_schema!

  config.include FactoryGirl::Syntax::Methods
  config.include SpecHelpers::Request, type: :request
  config.include SpecHelpers::Dummy

  config.infer_spec_type_from_file_location!

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
