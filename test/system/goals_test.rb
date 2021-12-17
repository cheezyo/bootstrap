require "application_system_test_case"

class GoalsTest < ApplicationSystemTestCase
  setup do
    @goal = goals(:one)
  end

  test "visiting the index" do
    visit goals_url
    assert_selector "h1", text: "Goals"
  end

  test "creating a Goal" do
    visit goals_url
    click_on "New Goal"

    fill_in "Dream", with: @goal.dream
    fill_in "Long", with: @goal.long
    fill_in "Medium one", with: @goal.medium_one
    fill_in "Medium two", with: @goal.medium_two
    fill_in "Player", with: @goal.player_id
    fill_in "Short one", with: @goal.short_one
    fill_in "Short three", with: @goal.short_three
    fill_in "Short two", with: @goal.short_two
    click_on "Create Goal"

    assert_text "Goal was successfully created"
    click_on "Back"
  end

  test "updating a Goal" do
    visit goals_url
    click_on "Edit", match: :first

    fill_in "Dream", with: @goal.dream
    fill_in "Long", with: @goal.long
    fill_in "Medium one", with: @goal.medium_one
    fill_in "Medium two", with: @goal.medium_two
    fill_in "Player", with: @goal.player_id
    fill_in "Short one", with: @goal.short_one
    fill_in "Short three", with: @goal.short_three
    fill_in "Short two", with: @goal.short_two
    click_on "Update Goal"

    assert_text "Goal was successfully updated"
    click_on "Back"
  end

  test "destroying a Goal" do
    visit goals_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Goal was successfully destroyed"
  end
end
