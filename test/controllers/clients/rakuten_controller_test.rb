require 'test_helper'

class Clients::RakutenControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get clients_rakuten_search_url
    assert_response :success
  end

end
