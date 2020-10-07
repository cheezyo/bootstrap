require 'test_helper'

class TypeOfTraningsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @type_of_traning = type_of_tranings(:one)
  end

  test "should get index" do
    get type_of_tranings_url
    assert_response :success
  end

  test "should get new" do
    get new_type_of_traning_url
    assert_response :success
  end

  test "should create type_of_traning" do
    assert_difference('TypeOfTraning.count') do
      post type_of_tranings_url, params: { type_of_traning: { type_t: @type_of_traning.type_t } }
    end

    assert_redirected_to type_of_traning_url(TypeOfTraning.last)
  end

  test "should show type_of_traning" do
    get type_of_traning_url(@type_of_traning)
    assert_response :success
  end

  test "should get edit" do
    get edit_type_of_traning_url(@type_of_traning)
    assert_response :success
  end

  test "should update type_of_traning" do
    patch type_of_traning_url(@type_of_traning), params: { type_of_traning: { type_t: @type_of_traning.type_t } }
    assert_redirected_to type_of_traning_url(@type_of_traning)
  end

  test "should destroy type_of_traning" do
    assert_difference('TypeOfTraning.count', -1) do
      delete type_of_traning_url(@type_of_traning)
    end

    assert_redirected_to type_of_tranings_url
  end
end
