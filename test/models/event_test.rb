require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @event = Event.new(
      name: 'Balkan Ruby',
      active: true,
      description: 'The annual ruby conference on the Balkan peninsula'
    )
  end

  test 'should not save an invalid event' do
    event = Event.new

    assert_not event.save
  end

  test 'should save a valid event' do
    assert @event.save
  end

  test 'should not save a event without a name' do
    @event.name = nil

    assert_not @event.save
    assert_not_nil @event.errors[:name]
  end

  test 'should not save a event without active' do
    @event.active = nil

    assert_not @event.save
    assert_not_nil @event.errors[:active]
  end

  test 'should not save a event without a description' do
    @event.description = nil

    assert_not @event.save
    assert_not_nil @event.errors[:description]
  end
end
