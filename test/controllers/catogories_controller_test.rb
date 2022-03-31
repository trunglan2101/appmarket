require "test_helper"

class CatogoriesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get catogories_index_url
    assert_response :success
  end

  test "should get show" do
    get catogories_show_url
    assert_response :success
  end

  test "should get new" do
    get catogories_new_url
    assert_response :success
  end

  test "should get edit" do
    get catogories_edit_url
    assert_response :success
  end
end
