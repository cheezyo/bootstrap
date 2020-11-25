require "application_system_test_case"

class PeriodizationsTest < ApplicationSystemTestCase
  setup do
    @periodization = periodizations(:one)
  end

  test "visiting the index" do
    visit periodizations_url
    assert_selector "h1", text: "Periodizations"
  end

  test "creating a Periodization" do
    visit periodizations_url
    click_on "New Periodization"

    fill_in "Physical focus", with: @periodization.physical_focus
    fill_in "Physical intesity", with: @periodization.physical_intesity
    fill_in "Tennis focus", with: @periodization.tennis_focus
    fill_in "Tennis intesity", with: @periodization.tennis_intesity
    fill_in "Week", with: @periodization.week
    click_on "Create Periodization"

    assert_text "Periodization was successfully created"
    click_on "Back"
  end

  test "updating a Periodization" do
    visit periodizations_url
    click_on "Edit", match: :first

    fill_in "Physical focus", with: @periodization.physical_focus
    fill_in "Physical intesity", with: @periodization.physical_intesity
    fill_in "Tennis focus", with: @periodization.tennis_focus
    fill_in "Tennis intesity", with: @periodization.tennis_intesity
    fill_in "Week", with: @periodization.week
    click_on "Update Periodization"

    assert_text "Periodization was successfully updated"
    click_on "Back"
  end

  test "destroying a Periodization" do
    visit periodizations_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Periodization was successfully destroyed"
  end
end
