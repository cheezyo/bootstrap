require 'test_helper'

class PeriodizationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @periodization = periodizations(:one)
  end

  test "should get index" do
    get periodizations_url
    assert_response :success
  end

  test "should get new" do
    get new_periodization_url
    assert_response :success
  end

  test "should create periodization" do
    assert_difference('Periodization.count') do
      post periodizations_url, params: { periodization: { physical_focus: @periodization.physical_focus, physical_intesity: @periodization.physical_intesity, tennis_focus: @periodization.tennis_focus, tennis_intesity: @periodization.tennis_intesity, week: @periodization.week } }
    end

    assert_redirected_to periodization_url(Periodization.last)
  end

  test "should show periodization" do
    get periodization_url(@periodization)
    assert_response :success
  end

  test "should get edit" do
    get edit_periodization_url(@periodization)
    assert_response :success
  end

  test "should update periodization" do
    patch periodization_url(@periodization), params: { periodization: { physical_focus: @periodization.physical_focus, physical_intesity: @periodization.physical_intesity, tennis_focus: @periodization.tennis_focus, tennis_intesity: @periodization.tennis_intesity, week: @periodization.week } }
    assert_redirected_to periodization_url(@periodization)
  end

  test "should destroy periodization" do
    assert_difference('Periodization.count', -1) do
      delete periodization_url(@periodization)
    end

    assert_redirected_to periodizations_url
  end
end
