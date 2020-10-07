require "application_system_test_case"

class TypeOfTraningsTest < ApplicationSystemTestCase
  setup do
    @type_of_traning = type_of_tranings(:one)
  end

  test "visiting the index" do
    visit type_of_tranings_url
    assert_selector "h1", text: "Type Of Tranings"
  end

  test "creating a Type of traning" do
    visit type_of_tranings_url
    click_on "New Type Of Traning"

    fill_in "Type t", with: @type_of_traning.type_t
    click_on "Create Type of traning"

    assert_text "Type of traning was successfully created"
    click_on "Back"
  end

  test "updating a Type of traning" do
    visit type_of_tranings_url
    click_on "Edit", match: :first

    fill_in "Type t", with: @type_of_traning.type_t
    click_on "Update Type of traning"

    assert_text "Type of traning was successfully updated"
    click_on "Back"
  end

  test "destroying a Type of traning" do
    visit type_of_tranings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Type of traning was successfully destroyed"
  end
end
