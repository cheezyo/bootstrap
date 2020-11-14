require "application_system_test_case"

class TypeOfExercisesTest < ApplicationSystemTestCase
  setup do
    @type_of_exercise = type_of_exercises(:one)
  end

  test "visiting the index" do
    visit type_of_exercises_url
    assert_selector "h1", text: "Type Of Exercises"
  end

  test "creating a Type of exercise" do
    visit type_of_exercises_url
    click_on "New Type Of Exercise"

    fill_in "Title", with: @type_of_exercise.title
    click_on "Create Type of exercise"

    assert_text "Type of exercise was successfully created"
    click_on "Back"
  end

  test "updating a Type of exercise" do
    visit type_of_exercises_url
    click_on "Edit", match: :first

    fill_in "Title", with: @type_of_exercise.title
    click_on "Update Type of exercise"

    assert_text "Type of exercise was successfully updated"
    click_on "Back"
  end

  test "destroying a Type of exercise" do
    visit type_of_exercises_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Type of exercise was successfully destroyed"
  end
end
