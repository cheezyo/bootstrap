require "application_system_test_case"

class TournamentsTest < ApplicationSystemTestCase
  setup do
    @tournament = tournaments(:one)
  end

  test "visiting the index" do
    visit tournaments_url
    assert_selector "h1", text: "Tournaments"
  end

  test "creating a Tournament" do
    visit tournaments_url
    click_on "New Tournament"

    fill_in "Title", with: @tournament.title
    check "U11" if @tournament.u11
    check "U12" if @tournament.u12
    check "U13" if @tournament.u13
    check "U14" if @tournament.u14
    check "U15" if @tournament.u15
    check "U16" if @tournament.u16
    check "U19" if @tournament.u19
    fill_in "Url", with: @tournament.url
    click_on "Create Tournament"

    assert_text "Tournament was successfully created"
    click_on "Back"
  end

  test "updating a Tournament" do
    visit tournaments_url
    click_on "Edit", match: :first

    fill_in "Title", with: @tournament.title
    check "U11" if @tournament.u11
    check "U12" if @tournament.u12
    check "U13" if @tournament.u13
    check "U14" if @tournament.u14
    check "U15" if @tournament.u15
    check "U16" if @tournament.u16
    check "U19" if @tournament.u19
    fill_in "Url", with: @tournament.url
    click_on "Update Tournament"

    assert_text "Tournament was successfully updated"
    click_on "Back"
  end

  test "destroying a Tournament" do
    visit tournaments_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Tournament was successfully destroyed"
  end
end
