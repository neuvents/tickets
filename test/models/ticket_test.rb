require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  def setup
    @ticket = Ticket.new(
      ticket_type: ticket_types(:early_bird),
      uid: 'some-not-so-random-uid',
      first_name: 'John',
      last_name: 'Doe',
      email: 'john@example.com'
    )
  end

  test 'should not save an invalid ticket' do
    ticket = Ticket.new

    assert_not ticket.save
  end

  test 'should save a valid ticket' do
    assert @ticket.save
  end

  test 'should not save a ticket without a ticket_type' do
    @ticket.ticket_type = nil

    assert_not @ticket.save
    assert_not_nil @ticket.errors[:ticket_type]
  end

  test 'should not save a ticket without a uid' do
    @ticket.uid = nil

    assert_not @ticket.save
    assert_not_nil @ticket.errors[:uid]
  end

  test 'should not save a ticket with a duplicated uid' do
    @ticket.save

    ticket = Ticket.new(@ticket.attributes.except('id'))

    error = assert_raises ActiveRecord::RecordNotUnique do
      ticket.save
    end

    assert error.message.include?('duplicate key value violates unique constraint')
    assert error.message.include?('uid')
  end

  test 'should not save a ticket without a first_name' do
    @ticket.first_name = nil

    assert_not @ticket.save
    assert_not_nil @ticket.errors[:first_name]
  end

  test 'should not save a ticket without a last_name' do
    @ticket.last_name = nil

    assert_not @ticket.save
    assert_not_nil @ticket.errors[:last_name]
  end

  test 'should not save a ticket without a email' do
    @ticket.email = nil

    assert_not @ticket.save
    assert_not_nil @ticket.errors[:email]
  end

  test 'should not update uid in the database' do
    @ticket.save!
    @ticket.uid = 'new-uid-value'
    @ticket.save!

    assert_equal 'some-not-so-random-uid', @ticket.reload.uid
  end
end
