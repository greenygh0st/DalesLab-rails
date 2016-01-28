require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  test "should not save subscription without email" do
    subsc = Subscription.new
    assert_not subsc.save
  end

  test "should not save subscription without a valid email" do
    subsc = Subscription.new
    subsc.email = "john@doecom"
    assert_not subsc.save
  end
end
