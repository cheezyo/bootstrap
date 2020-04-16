require 'test_helper'

class TrainingProgramsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @training_program = training_programs(:one)
  end

  test "should get index" do
    get training_programs_url
    assert_response :success
  end

  test "should get new" do
    get new_training_program_url
    assert_response :success
  end

  test "should create training_program" do
    assert_difference('TrainingProgram.count') do
      post training_programs_url, params: { training_program: { prog_name: @training_program.prog_name, prog_number: @training_program.prog_number, prog_url: @training_program.prog_url } }
    end

    assert_redirected_to training_program_url(TrainingProgram.last)
  end

  test "should show training_program" do
    get training_program_url(@training_program)
    assert_response :success
  end

  test "should get edit" do
    get edit_training_program_url(@training_program)
    assert_response :success
  end

  test "should update training_program" do
    patch training_program_url(@training_program), params: { training_program: { prog_name: @training_program.prog_name, prog_number: @training_program.prog_number, prog_url: @training_program.prog_url } }
    assert_redirected_to training_program_url(@training_program)
  end

  test "should destroy training_program" do
    assert_difference('TrainingProgram.count', -1) do
      delete training_program_url(@training_program)
    end

    assert_redirected_to training_programs_url
  end
end
