require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  def setup
    @order = Order.new(
      uid: 'some-pseudo-random-uid',
      first_name: "John",
      last_name: "Doe",
      email: "john@example.com",
      payment_type: "credit_card",
      date: DateTime.new(2018, 3, 18, 17, 54, 54),
      legal_entity: true,
      company: "Aperture technologies",
      company_uid: "12345678",
      company_vat_uid: "BG12345678",
      country: "Bulgaria",
      city: "Sofia",
      zip: "1407",
      address: "ul. Banat 3"
    )
  end

  test 'should not save an invalid order' do
    order = Order.new

    assert_not order.save
  end

  test 'should save an valid order' do
    assert @order.save
  end

  test 'should not save an order without a uid' do
    @order.uid = nil

    assert_not @order.save
    assert_not_nil @order.errors[:uid]
  end

  test 'should not save an order with a duplicated uid' do
    @order.save

    order = Order.new(@order.attributes.except('id'))

    error = assert_raises ActiveRecord::RecordNotUnique do
      order.save
    end

    assert error.message.include?('duplicate key value violates unique constraint')
    assert error.message.include?('uid')
  end

  test 'should not save an order without a first_name' do
    @order.first_name = nil

    assert_not @order.save
    assert_not_nil @order.errors[:first_name]
  end

  test 'should not save an order without a last_name' do
    @order.last_name = nil

    assert_not @order.save
    assert_not_nil @order.errors[:last_name]
  end

  test 'should not save an order without a email' do
    @order.email = nil

    assert_not @order.save
    assert_not_nil @order.errors[:email]
  end

  test 'should not save an order without a payment_type' do
    @order.payment_type = nil

    assert_not @order.save
    assert_not_nil @order.errors[:payment_type]
  end

  test 'should not allow setting of an invalid payment_type' do
    error = assert_raises ArgumentError do
      @order.payment_type = 'bogus-payment-type'
    end

    assert error.message.include?("bogus-payment-type' is not a valid payment_type")
  end

  test 'should not save an order without a date' do
    @order.date = nil

    assert_not @order.save
    assert_not_nil @order.errors[:date]
  end

  test 'should not save an order without a legal_entity' do
    @order.legal_entity = nil

    assert_not @order.save
    assert_not_nil @order.errors[:legal_entity]
  end

  test 'should not save an order with company being nil' do
    @order.company = nil

    assert_not @order.save
    assert_not_nil @order.errors[:company]
  end

  test 'should save an order with a company being empty string' do
    @order.company = ''

    assert @order.save
  end

  test 'should not save an order with company_uid being nil' do
    @order.company_uid = nil

    assert_not @order.save
    assert_not_nil @order.errors[:company_uid]
  end

  test 'should save an order with a company_uid being empty string' do
    @order.company_uid = ''

    assert @order.save
  end

  test 'should not save an order with company_vat_uid being nil' do
    @order.company_vat_uid = nil

    assert_not @order.save
    assert_not_nil @order.errors[:company_vat_uid]
  end

  test 'should save an order with a company_vat_uid being empty string' do
    @order.company_vat_uid = ''

    assert @order.save
  end

  test 'should not save an order with country being nil' do
    @order.country = nil

    assert_not @order.save
    assert_not_nil @order.errors[:country]
  end

  test 'should save an order with a country being empty string' do
    @order.country = ''

    assert @order.save
  end

  test 'should not save an order with city being nil' do
    @order.city = nil

    assert_not @order.save
    assert_not_nil @order.errors[:city]
  end

  test 'should save an order with a city being empty string' do
    @order.city = ''

    assert @order.save
  end

  test 'should not save an order with zip being nil' do
    @order.zip = nil

    assert_not @order.save
    assert_not_nil @order.errors[:zip]
  end

  test 'should save an order with a zip being empty string' do
    @order.zip = ''

    assert @order.save
  end

    test 'should not save an order with address being nil' do
    @order.address = nil

    assert_not @order.save
    assert_not_nil @order.errors[:address]
  end

  test 'should save an order with a address being empty string' do
    @order.address = ''

    assert @order.save
  end

  test 'should not update uid in the database' do
    @order.save!
    @order.uid = 'new-uid-value'
    @order.save!

    assert_equal 'some-pseudo-random-uid', @order.reload.uid
  end
end
