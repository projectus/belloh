require 'test_helper'

class InformationControllerTest < ActionController::TestCase
  test "should get about" do
    get :about
    assert_response :success
  end

  test "should get help" do
    get :help
    assert_response :success
  end

  test "should get terms" do
    get :terms
    assert_response :success
  end

  test "should get privacy" do
    get :privacy
    assert_response :success
  end

  test "should get hubs" do
    get :hubs
    assert_response :success
  end

  test "should get usage" do
    get :usage
    assert_response :success
  end

  test "should get blog" do
    get :blog
    assert_response :success
  end

  test "should get twitter" do
    get :twitter
    assert_response :success
  end

end
