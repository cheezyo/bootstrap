require 'test_helper'

class ExerciseTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise_type = exercise_types(:one)
  end

  test "should get index" do
    get exercise_types_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_type_url
    assert_response :success
  end

  test "should create exercise_type" do
    assert_difference('ExerciseType.count') do
      post exercise_types_url, params: { exercise_type: { string: @exercise_type.string } }
    end

    assert_redirected_to exercise_type_url(ExerciseType.last)
  end

  test "should show exercise_type" do
    get exercise_type_url(@exercise_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_exercise_type_url(@exercise_type)
    assert_response :success
  end

  test "should update exercise_type" do
    patch exercise_type_url(@exercise_type), params: { exercise_type: { string: @exercise_type.string } }
    assert_redirected_to exercise_type_url(@exercise_type)
  end

  test "should destroy exercise_type" do
    assert_difference('ExerciseType.count', -1) do
      delete exercise_type_url(@exercise_type)
    end

    assert_redirected_to exercise_types_url
  end
end
