require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should prompt for login" do
    get login_url
    assert_response :success
  end

  test "should login using user_name" do
      test_user = users(:one)
      post login_url, params: { identification: test_user.user_name, password: 'aa123456' }
      assert_redirected_to admin_url
      assert_equal test_user.id, session[:user_id]
  end

  test "should login using email" do
      test_user = users(:one)
      post login_url, params: { identification: test_user.email, password: 'aa123456' }
      assert_redirected_to admin_url
      assert_equal test_user.id, session[:user_id]
  end

  test "should login fail" do
    test_user = users(:one)
    post :login, params: { identification: test_user.user_name, password: 'isWrongPassword' }
    assert_redirected_to login_url
  end

  test "should logout" do
    delete logout_url
    assert_redirected_to mall_url
  end


  # test "should post login" do
  #   test_user = users(:one)
  #   post :login, :user_name => test_user.user_name, :password => '123456'
  #   assert_redirected_to admin_url
  #   assert_equal test_user.id, session[:user_id]
  # end
  #
  # test "should post login fail" do
  #   test_user = users(:one)
  #   post :login, params: { user_name: test_user.user_name, password: 'isWrongPassword' }
  #   assert_redirected_to login_url
  # end
  #
  # test "should delete logout" do
  #   delete logout_path
  #   assert_redirected_to mall_url
  # end


end
