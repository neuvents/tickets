require 'test_helper'

class LineItemTest < ActiveSupport::TestCase
  def setup
    @line_item = LineItem.new(
      ticket: tickets(:first),
      order: orders(:first),
      price: 1000,
      quantity: 2,
      currency: 'EUR'
    )
  end

  test 'should not save an invalid line_item' do
    line_item = LineItem.new

    assert_not line_item.save
  end

  test 'should save a valid line_item' do
    assert @line_item.save
  end

  test 'should not save a line_item without a ticket' do
    @line_item.ticket = nil

    assert_not @line_item.save
    assert_not_nil @line_item.errors[:ticket]
  end

  test 'should not save a line_item without a order' do
    @line_item.order = nil

    assert_not @line_item.save
    assert_not_nil @line_item.errors[:order]
  end

  test 'should not save a line_item without a price' do
    @line_item.price = nil

    assert_not @line_item.save
    assert_not_nil @line_item.errors[:price]
  end

  test 'should not save a line_item with fractional price' do
    @line_item.price = 1.5

    assert_not @line_item.save
    assert_not_nil @line_item.errors[:price]
  end

  test 'should not save a line_item with negative price' do
    @line_item.price = -2

    assert_not @line_item.save
    assert_not_nil @line_item.errors[:price]
  end

  test 'should not save a line_item without a currency' do
    @line_item.currency = nil

    assert_not @line_item.save
    assert_not_nil @line_item.errors[:currency]
  end

  test 'should not save a line_item with invalid currency' do
    @line_item.currency = 'blob'

    assert_not @line_item.save
    assert_not_nil @line_item.errors[:currency]
  end
end
