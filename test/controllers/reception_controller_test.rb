require 'test_helper'

class ReceptionControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get reception_index_url
    assert_response :success
  end

end
