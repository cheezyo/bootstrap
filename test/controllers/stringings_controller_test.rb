require 'test_helper'

class StringingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stringing = stringings(:one)
  end

  test "should get index" do
    get stringings_url
    assert_response :success
  end

  test "should get new" do
    get new_stringing_url
    assert_response :success
  end

  test "should create stringing" do
    assert_difference('Stringing.count') do
      post stringings_url, params: { stringing: { customer: @stringing.customer, delivered: @stringing.delivered, done: @stringing.done, paid: @stringing.paid, payment_registration: @stringing.payment_registration, payment_type: @stringing.payment_type, pick_up: @stringing.pick_up, price: @stringing.price, registered_by: @stringing.registered_by, tension: @stringing.tension, type_of_strings: @stringing.type_of_strings } }
    end

    assert_redirected_to stringing_url(Stringing.last)
  end

  test "should show stringing" do
    get stringing_url(@stringing)
    assert_response :success
  end

  test "should get edit" do
    get edit_stringing_url(@stringing)
    assert_response :success
  end

  test "should update stringing" do
    patch stringing_url(@stringing), params: { stringing: { customer: @stringing.customer, delivered: @stringing.delivered, done: @stringing.done, paid: @stringing.paid, payment_registration: @stringing.payment_registration, payment_type: @stringing.payment_type, pick_up: @stringing.pick_up, price: @stringing.price, registered_by: @stringing.registered_by, tension: @stringing.tension, type_of_strings: @stringing.type_of_strings } }
    assert_redirected_to stringing_url(@stringing)
  end

  test "should destroy stringing" do
    assert_difference('Stringing.count', -1) do
      delete stringing_url(@stringing)
    end

    assert_redirected_to stringings_url
  end
end
