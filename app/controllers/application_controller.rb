class ApplicationController < ActionController::Base
  include RenderingHelper

  before_action :authorize
  # protect_from_forgery

  protected
    # 验证登录
    def authorize
      unless session[:user_id] && User.find_by_id(session[:user_id]['id'])
        redirect_to login_url, :alert => '请登录'
      end
    end

    # 验证管理权限
    def authorize_admin
      admin = session[:admin_id]
      if admin == nil || session[:user_id] == nil || admin[:user_id] == session[:user_id]['id']
        admin = Admin.find_by_id(session[:user_id]['id'])
        # TODO: 判断该管理员有权限路径
        if admin == nil
          redirect_to mall_url, :notice => '您无权访问该页面'
        else
          session[:admin_id] = admin
        end
      end
      admin
    end

end
