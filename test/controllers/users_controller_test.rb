require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  # test "should get index" do
  #   get users_url
  #   assert_response :success
  # end
  #
  # test "should get new" do
  #   get new_user_url
  #   assert_response :success
  # end

  test "should create user" do
    # assert_difference('User.count') do
    #   # post users_url, params: { user: { user_name: @user.user_name, password: 'secret', password_confirmation: 'secret',
    #   #                                   email: 'aaa@aaa.com' } }
    #   # post users_url, params: { user: { user_name: 'test123', password: 'secret', password_confirmation: 'secret',
    #   #                                   email: 'aaa@aaa.com' } }
    #   post users_url, params: { user: { user_name: 'test', password: 'secret', password_confirmation: 'secret',
    #                                     email: 'aaa@aaa.com' } }
    # end
    #
    # assert_redirected_to user_url(User.last)
  end

  # test "should show user" do
  #   get user_url(@user)
  #   assert_response :success
  # end
  #
  # test "should get edit" do
  #   get edit_user_url(@user)
  #   assert_response :success
  # end

  test "should update user" do
    # 非法情况

    # patch user_url(@user), params: { user: { id: @user.id, email: @user.email, password: 'secret', password_confirmation: 'wrong_password' } }
    # assert_redirected_to user_url(@user)

    # patch user_url(@user), params: { user: { user_name: @user.user_name, email: @user.email, password: 'secret123', password_confirmation: 'secret' } }
    # assert_redirected_to user_url(@user)

    # patch user_url(@user), params: { user: { user_name: @user.user_name, email: @user.email } }
    # assert_redirected_to user_url(@user)

    # 合法情况

    patch user_url(@user), params: { user: { user_name: @user.user_name, email: @user.email, password: 'secret', password_confirmation: 'secret' } }
    assert_redirected_to user_url(@user)

    patch user_url(@user), params: { user: { id: @user.id, email: @user.email, password: 'secret', password_confirmation: 'secret' } }
    assert_redirected_to user_url(@user)
  end

  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete user_url(@user)
  #   end
  #
  #   assert_redirected_to users_url
  # end
end
