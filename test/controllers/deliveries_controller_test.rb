require "test_helper"

class DeliveriesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get deliveries_new_url
    assert_response :success
  end

  test "should get create" do
    get deliveries_create_url
    assert_response :success
  end

  test "should get edit" do
    get deliveries_edit_url
    assert_response :success
  end

  test "should get update" do
    get deliveries_update_url
    assert_response :success
  end
end
