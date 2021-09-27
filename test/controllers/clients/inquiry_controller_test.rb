require 'test_helper'

class Clients::InquiryControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get clients_inquiry_index_url
    assert_response :success
  end

  test "should get confirm" do
    get clients_inquiry_confirm_url
    assert_response :success
  end

  test "should get thanks" do
    get clients_inquiry_thanks_url
    assert_response :success
  end

end
