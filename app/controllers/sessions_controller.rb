class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]

  def new
    @dont_use_footer = true
  end

  def create
    user = User.find_by_sql(["select users.* from users where user_name = ? or email = ? limit 1",
                            params[:identification], params[:identification]])[0]
    unless verify_rucaptcha?(@user)
      redirect_to login_url, :alert => "验证码错误"
    else
      if user.try(:authenticate, params[:password])
        session[:user_id] = User.new(:id => user.id, :user_name => user.user_name, :email => user.email)
        redirect_to mall_url
      else
        redirect_to login_url, :alert => "用户名、邮箱或密码有误"
      end
    end
  end

  def destroy
    session[:user_id] = nil
    session[:admin_id] = nil
    redirect_to login_url, :notice => '注销成功'
  end
end
