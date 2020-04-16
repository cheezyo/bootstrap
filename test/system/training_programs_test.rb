require "application_system_test_case"

class TrainingProgramsTest < ApplicationSystemTestCase
  setup do
    @training_program = training_programs(:one)
  end

  test "visiting the index" do
    visit training_programs_url
    assert_selector "h1", text: "Training Programs"
  end

  test "creating a Training program" do
    visit training_programs_url
    click_on "New Training Program"

    fill_in "Prog name", with: @training_program.prog_name
    fill_in "Prog number", with: @training_program.prog_number
    fill_in "Prog url", with: @training_program.prog_url
    click_on "Create Training program"

    assert_text "Training program was successfully created"
    click_on "Back"
  end

  test "updating a Training program" do
    visit training_programs_url
    click_on "Edit", match: :first

    fill_in "Prog name", with: @training_program.prog_name
    fill_in "Prog number", with: @training_program.prog_number
    fill_in "Prog url", with: @training_program.prog_url
    click_on "Update Training program"

    assert_text "Training program was successfully updated"
    click_on "Back"
  end

  test "destroying a Training program" do
    visit training_programs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Training program was successfully destroyed"
  end
end
