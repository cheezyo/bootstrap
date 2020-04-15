require 'test_helper'

class TestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @test = tests(:one)
  end

  test "should get index" do
    get tests_url
    assert_response :success
  end

  test "should get new" do
    get new_test_url
    assert_response :success
  end

  test "should create test" do
    assert_difference('Test.count') do
      post tests_url, params: { test: { age: @test.age, back_stretch: @test.back_stretch, beep: @test.beep, bh_throw: @test.bh_throw, box: @test.box, chins: @test.chins, fh_throw: @test.fh_throw, front_stretch: @test.front_stretch, gender: @test.gender, jump: @test.jump, player_id: @test.player_id, program1: @test.program1, program2: @test.program2, pushups: @test.pushups, situps: @test.situps, spider: @test.spider, sprint: @test.sprint, test_group_id: @test.test_group_id, test_score: @test.test_score, test_type: @test.test_type } }
    end

    assert_redirected_to test_url(Test.last)
  end

  test "should show test" do
    get test_url(@test)
    assert_response :success
  end

  test "should get edit" do
    get edit_test_url(@test)
    assert_response :success
  end

  test "should update test" do
    patch test_url(@test), params: { test: { age: @test.age, back_stretch: @test.back_stretch, beep: @test.beep, bh_throw: @test.bh_throw, box: @test.box, chins: @test.chins, fh_throw: @test.fh_throw, front_stretch: @test.front_stretch, gender: @test.gender, jump: @test.jump, player_id: @test.player_id, program1: @test.program1, program2: @test.program2, pushups: @test.pushups, situps: @test.situps, spider: @test.spider, sprint: @test.sprint, test_group_id: @test.test_group_id, test_score: @test.test_score, test_type: @test.test_type } }
    assert_redirected_to test_url(@test)
  end

  test "should destroy test" do
    assert_difference('Test.count', -1) do
      delete test_url(@test)
    end

    assert_redirected_to tests_url
  end
end
