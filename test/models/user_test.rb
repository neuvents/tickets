require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      email: 'john@example.com',
      password: 'Regular'
    )
  end

  test 'should not save an invalid user' do
    user = User.new

    assert_not user.save
  end

  test 'should save a valid user' do
    assert @user.save
  end

  test 'should not save a user without an email' do
    @user.email = nil

    assert_not @user.save
    assert_not_nil @user.errors[:email]
  end
end
