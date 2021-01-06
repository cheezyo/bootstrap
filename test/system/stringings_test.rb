require "application_system_test_case"

class StringingsTest < ApplicationSystemTestCase
  setup do
    @stringing = stringings(:one)
  end

  test "visiting the index" do
    visit stringings_url
    assert_selector "h1", text: "Stringings"
  end

  test "creating a Stringing" do
    visit stringings_url
    click_on "New Stringing"

    fill_in "Customer", with: @stringing.customer
    fill_in "Delivered", with: @stringing.delivered
    fill_in "Done", with: @stringing.done
    fill_in "Paid", with: @stringing.paid
    fill_in "Payment registration", with: @stringing.payment_registration
    fill_in "Payment type", with: @stringing.payment_type
    fill_in "Pick up", with: @stringing.pick_up
    fill_in "Price", with: @stringing.price
    fill_in "Registered by", with: @stringing.registered_by
    fill_in "Tension", with: @stringing.tension
    fill_in "Type of strings", with: @stringing.type_of_strings
    click_on "Create Stringing"

    assert_text "Stringing was successfully created"
    click_on "Back"
  end

  test "updating a Stringing" do
    visit stringings_url
    click_on "Edit", match: :first

    fill_in "Customer", with: @stringing.customer
    fill_in "Delivered", with: @stringing.delivered
    fill_in "Done", with: @stringing.done
    fill_in "Paid", with: @stringing.paid
    fill_in "Payment registration", with: @stringing.payment_registration
    fill_in "Payment type", with: @stringing.payment_type
    fill_in "Pick up", with: @stringing.pick_up
    fill_in "Price", with: @stringing.price
    fill_in "Registered by", with: @stringing.registered_by
    fill_in "Tension", with: @stringing.tension
    fill_in "Type of strings", with: @stringing.type_of_strings
    click_on "Update Stringing"

    assert_text "Stringing was successfully updated"
    click_on "Back"
  end

  test "destroying a Stringing" do
    visit stringings_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stringing was successfully destroyed"
  end
end
