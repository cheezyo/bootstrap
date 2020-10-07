require "application_system_test_case"

class TypeOfTrainingsTest < ApplicationSystemTestCase
  setup do
    @type_of_training = type_of_trainings(:one)
  end

  test "visiting the index" do
    visit type_of_trainings_url
    assert_selector "h1", text: "Type Of Trainings"
  end

  test "creating a Type of training" do
    visit type_of_trainings_url
    click_on "New Type Of Training"

    fill_in "Title", with: @type_of_training.title
    click_on "Create Type of training"

    assert_text "Type of training was successfully created"
    click_on "Back"
  end

  test "updating a Type of training" do
    visit type_of_trainings_url
    click_on "Edit", match: :first

    fill_in "Title", with: @type_of_training.title
    click_on "Update Type of training"

    assert_text "Type of training was successfully updated"
    click_on "Back"
  end

  test "destroying a Type of training" do
    visit type_of_trainings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Type of training was successfully destroyed"
  end
end
