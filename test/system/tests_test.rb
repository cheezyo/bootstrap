require "application_system_test_case"

class TestsTest < ApplicationSystemTestCase
  setup do
    @test = tests(:one)
  end

  test "visiting the index" do
    visit tests_url
    assert_selector "h1", text: "Tests"
  end

  test "creating a Test" do
    visit tests_url
    click_on "New Test"

    fill_in "Age", with: @test.age
    fill_in "Back stretch", with: @test.back_stretch
    fill_in "Beep", with: @test.beep
    fill_in "Bh throw", with: @test.bh_throw
    fill_in "Box", with: @test.box
    fill_in "Chins", with: @test.chins
    fill_in "Fh throw", with: @test.fh_throw
    fill_in "Front stretch", with: @test.front_stretch
    fill_in "Gender", with: @test.gender
    fill_in "Jump", with: @test.jump
    fill_in "Player", with: @test.player_id
    fill_in "Program1", with: @test.program1
    fill_in "Program2", with: @test.program2
    fill_in "Pushups", with: @test.pushups
    fill_in "Situps", with: @test.situps
    fill_in "Spider", with: @test.spider
    fill_in "Sprint", with: @test.sprint
    fill_in "Test group", with: @test.test_group_id
    fill_in "Test score", with: @test.test_score
    fill_in "Test type", with: @test.test_type
    click_on "Create Test"

    assert_text "Test was successfully created"
    click_on "Back"
  end

  test "updating a Test" do
    visit tests_url
    click_on "Edit", match: :first

    fill_in "Age", with: @test.age
    fill_in "Back stretch", with: @test.back_stretch
    fill_in "Beep", with: @test.beep
    fill_in "Bh throw", with: @test.bh_throw
    fill_in "Box", with: @test.box
    fill_in "Chins", with: @test.chins
    fill_in "Fh throw", with: @test.fh_throw
    fill_in "Front stretch", with: @test.front_stretch
    fill_in "Gender", with: @test.gender
    fill_in "Jump", with: @test.jump
    fill_in "Player", with: @test.player_id
    fill_in "Program1", with: @test.program1
    fill_in "Program2", with: @test.program2
    fill_in "Pushups", with: @test.pushups
    fill_in "Situps", with: @test.situps
    fill_in "Spider", with: @test.spider
    fill_in "Sprint", with: @test.sprint
    fill_in "Test group", with: @test.test_group_id
    fill_in "Test score", with: @test.test_score
    fill_in "Test type", with: @test.test_type
    click_on "Update Test"

    assert_text "Test was successfully updated"
    click_on "Back"
  end

  test "destroying a Test" do
    visit tests_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Test was successfully destroyed"
  end
end
