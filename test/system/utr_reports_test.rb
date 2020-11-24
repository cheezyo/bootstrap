require "application_system_test_case"

class UtrReportsTest < ApplicationSystemTestCase
  setup do
    @utr_report = utr_reports(:one)
  end

  test "visiting the index" do
    visit utr_reports_url
    assert_selector "h1", text: "Utr Reports"
  end

  test "creating a Utr report" do
    visit utr_reports_url
    click_on "New Utr Report"

    fill_in "Boys", with: @utr_report.boys
    fill_in "Girls", with: @utr_report.girls
    fill_in "Utr date", with: @utr_report.utr_date
    click_on "Create Utr report"

    assert_text "Utr report was successfully created"
    click_on "Back"
  end

  test "updating a Utr report" do
    visit utr_reports_url
    click_on "Edit", match: :first

    fill_in "Boys", with: @utr_report.boys
    fill_in "Girls", with: @utr_report.girls
    fill_in "Utr date", with: @utr_report.utr_date
    click_on "Update Utr report"

    assert_text "Utr report was successfully updated"
    click_on "Back"
  end

  test "destroying a Utr report" do
    visit utr_reports_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Utr report was successfully destroyed"
  end
end
