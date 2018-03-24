require 'test_helper'

class TicketTypeTest < ActiveSupport::TestCase
  def setup
    @ticket_type = TicketType.new(
      event: events(:balkan_ruby),
      name: 'Regular',
      active: false,
      price: 1000,
      currency: 'EUR'
    )
  end

  test 'should save a valid ticket type' do
    assert @ticket_type.save
  end

  test 'should not save a ticket type without event' do
    @ticket_type.event = nil

    assert_not @ticket_type.save
    assert_not_nil @ticket_type.errors[:event]
  end

  test 'should not save a ticket type without name' do
    @ticket_type.name = nil

    assert_not @ticket_type.save
    assert_not_nil @ticket_type.errors[:name]
  end

  test 'should not save a ticket type without active' do
    @ticket_type.active = nil

    assert_not @ticket_type.save
    assert_not_nil @ticket_type.errors[:active]
  end

  test 'should not save a ticket type without price' do
    @ticket_type.price = nil

    assert_not @ticket_type.save
    assert_not_nil @ticket_type.errors[:price]
  end

  test 'should not save a ticket type with fractional price' do
    @ticket_type.price = 1.5

    assert_not @ticket_type.save
    assert_not_nil @ticket_type.errors[:price]
  end

  test 'should not save a ticket type with negative price' do
    @ticket_type.price = -20

    assert_not @ticket_type.save
    assert_not_nil @ticket_type.errors[:price]
  end

  test 'should not save a ticket type without currency' do
    @ticket_type.currency = nil

    assert_not @ticket_type.save
    assert_not_nil @ticket_type.errors[:currency]
  end

  test 'should not save a ticket type with invalid currency' do
    @ticket_type.currency = 'BLA'

    assert_not @ticket_type.save
    assert_not_nil @ticket_type.errors[:currency]
  end
end
