ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

Rails.root.join('test', 'support').each_child(&Kernel.method(:require))
Rails.root.join('test', 'helpers').each_child(&Kernel.method(:require))

Token.secret = 'test1234'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  include Testing::JSONAssertions
end

class ActionDispatch::IntegrationTest
  include Testing::AuthenticationHelper
end
