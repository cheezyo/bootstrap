require 'test_helper'

class TestGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @test_group = test_groups(:one)
  end

  test "should get index" do
    get test_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_test_group_url
    assert_response :success
  end

  test "should create test_group" do
    assert_difference('TestGroup.count') do
      post test_groups_url, params: { test_group: { date: @test_group.date, title: @test_group.title } }
    end

    assert_redirected_to test_group_url(TestGroup.last)
  end

  test "should show test_group" do
    get test_group_url(@test_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_test_group_url(@test_group)
    assert_response :success
  end

  test "should update test_group" do
    patch test_group_url(@test_group), params: { test_group: { date: @test_group.date, title: @test_group.title } }
    assert_redirected_to test_group_url(@test_group)
  end

  test "should destroy test_group" do
    assert_difference('TestGroup.count', -1) do
      delete test_group_url(@test_group)
    end

    assert_redirected_to test_groups_url
  end
end
