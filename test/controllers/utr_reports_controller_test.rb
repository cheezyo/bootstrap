require 'test_helper'

class UtrReportsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @utr_report = utr_reports(:one)
  end

  test "should get index" do
    get utr_reports_url
    assert_response :success
  end

  test "should get new" do
    get new_utr_report_url
    assert_response :success
  end

  test "should create utr_report" do
    assert_difference('UtrReport.count') do
      post utr_reports_url, params: { utr_report: { boys: @utr_report.boys, girls: @utr_report.girls, utr_date: @utr_report.utr_date } }
    end

    assert_redirected_to utr_report_url(UtrReport.last)
  end

  test "should show utr_report" do
    get utr_report_url(@utr_report)
    assert_response :success
  end

  test "should get edit" do
    get edit_utr_report_url(@utr_report)
    assert_response :success
  end

  test "should update utr_report" do
    patch utr_report_url(@utr_report), params: { utr_report: { boys: @utr_report.boys, girls: @utr_report.girls, utr_date: @utr_report.utr_date } }
    assert_redirected_to utr_report_url(@utr_report)
  end

  test "should destroy utr_report" do
    assert_difference('UtrReport.count', -1) do
      delete utr_report_url(@utr_report)
    end

    assert_redirected_to utr_reports_url
  end
end
