require 'test_helper'

class TypeOfExercisesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @type_of_exercise = type_of_exercises(:one)
  end

  test "should get index" do
    get type_of_exercises_url
    assert_response :success
  end

  test "should get new" do
    get new_type_of_exercise_url
    assert_response :success
  end

  test "should create type_of_exercise" do
    assert_difference('TypeOfExercise.count') do
      post type_of_exercises_url, params: { type_of_exercise: { title: @type_of_exercise.title } }
    end

    assert_redirected_to type_of_exercise_url(TypeOfExercise.last)
  end

  test "should show type_of_exercise" do
    get type_of_exercise_url(@type_of_exercise)
    assert_response :success
  end

  test "should get edit" do
    get edit_type_of_exercise_url(@type_of_exercise)
    assert_response :success
  end

  test "should update type_of_exercise" do
    patch type_of_exercise_url(@type_of_exercise), params: { type_of_exercise: { title: @type_of_exercise.title } }
    assert_redirected_to type_of_exercise_url(@type_of_exercise)
  end

  test "should destroy type_of_exercise" do
    assert_difference('TypeOfExercise.count', -1) do
      delete type_of_exercise_url(@type_of_exercise)
    end

    assert_redirected_to type_of_exercises_url
  end
end
