require 'test_helper'

class TypeOfTrainingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @type_of_training = type_of_trainings(:one)
  end

  test "should get index" do
    get type_of_trainings_url
    assert_response :success
  end

  test "should get new" do
    get new_type_of_training_url
    assert_response :success
  end

  test "should create type_of_training" do
    assert_difference('TypeOfTraining.count') do
      post type_of_trainings_url, params: { type_of_training: { title: @type_of_training.title } }
    end

    assert_redirected_to type_of_training_url(TypeOfTraining.last)
  end

  test "should show type_of_training" do
    get type_of_training_url(@type_of_training)
    assert_response :success
  end

  test "should get edit" do
    get edit_type_of_training_url(@type_of_training)
    assert_response :success
  end

  test "should update type_of_training" do
    patch type_of_training_url(@type_of_training), params: { type_of_training: { title: @type_of_training.title } }
    assert_redirected_to type_of_training_url(@type_of_training)
  end

  test "should destroy type_of_training" do
    assert_difference('TypeOfTraining.count', -1) do
      delete type_of_training_url(@type_of_training)
    end

    assert_redirected_to type_of_trainings_url
  end
end
