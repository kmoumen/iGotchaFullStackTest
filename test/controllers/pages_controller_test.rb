require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get user_details" do
    get :user_details
    assert_response :success
  end

  test "should get group_details" do
    get :group_details
    assert_response :success
  end

end
