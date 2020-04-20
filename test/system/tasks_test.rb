require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task = tasks(:one)
  end

  test "visiting the index" do
    visit tasks_url
    assert_selector "h1", text: "Tasks"
  end

  test "creating a Task" do
    visit tasks_url
    click_on "New Task"

    check "Done" if @task.done
    fill_in "Done date", with: @task.done_date
    fill_in "Player", with: @task.player_id
    fill_in "Progress", with: @task.progress
    fill_in "Task", with: @task.task
    fill_in "Task category", with: @task.task_category_id
    click_on "Create Task"

    assert_text "Task was successfully created"
    click_on "Back"
  end

  test "updating a Task" do
    visit tasks_url
    click_on "Edit", match: :first

    check "Done" if @task.done
    fill_in "Done date", with: @task.done_date
    fill_in "Player", with: @task.player_id
    fill_in "Progress", with: @task.progress
    fill_in "Task", with: @task.task
    fill_in "Task category", with: @task.task_category_id
    click_on "Update Task"

    assert_text "Task was successfully updated"
    click_on "Back"
  end

  test "destroying a Task" do
    visit tasks_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Task was successfully destroyed"
  end
end
