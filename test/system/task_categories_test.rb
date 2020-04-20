require "application_system_test_case"

class TaskCategoriesTest < ApplicationSystemTestCase
  setup do
    @task_category = task_categories(:one)
  end

  test "visiting the index" do
    visit task_categories_url
    assert_selector "h1", text: "Task Categories"
  end

  test "creating a Task category" do
    visit task_categories_url
    click_on "New Task Category"

    fill_in "Category", with: @task_category.category
    click_on "Create Task category"

    assert_text "Task category was successfully created"
    click_on "Back"
  end

  test "updating a Task category" do
    visit task_categories_url
    click_on "Edit", match: :first

    fill_in "Category", with: @task_category.category
    click_on "Update Task category"

    assert_text "Task category was successfully updated"
    click_on "Back"
  end

  test "destroying a Task category" do
    visit task_categories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Task category was successfully destroyed"
  end
end
