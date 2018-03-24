require 'test_helper'

class CurrencyTest < ActiveSupport::TestCase
  test 'find_by_iso_4217_code with valid input' do
    result = Currency.find_by_iso_4217_code 'EUR'

    assert_instance_of Currency, result
    assert_equal 'EUR', result.code
    assert_equal 'Euro', result.name
    assert_equal 2, result.exp
    assert_equal '978', result.num
  end

  test 'find_by_iso_4217_code with invalid input' do
    result = Currency.find_by_iso_4217_code 'BLA'

    assert_nil result
  end

  test 'to_minor conversion' do
    currency = Currency.new(code: 'EUR', name: 'Euro', exp: 2, num: '978')

    assert_equal 153, currency.to_minor(1.53)
  end

  test 'from_minor conversion' do
    currency = Currency.new(code: 'EUR', name: 'Euro', exp: 2, num: '978')

    assert_equal BigDecimal.new('1.53'), currency.from_minor(153)
  end
end
