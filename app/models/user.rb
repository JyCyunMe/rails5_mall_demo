class User < ApplicationRecord
  # has_one :admin

  # 验证变量 用户名，要求 存在、唯一
  # validates :user_name, :presence => true, :uniqueness => true
  validates_presence_of :user_name, :message => '用户名不能为空'
  validates_length_of :user_name, :minimum => 3, :maximum => 10, :message => '用户名长度必须为3~10位'
  validates_uniqueness_of :user_name, :case_sensitive => false, :message => '该用户名已存在'

  has_secure_password :validations => false
  # 验证 密码，要求 重复确认
  # validates :password, :confirmation => true
  validates_presence_of :password, :message => '密码不能为空'
  validates_length_of :password, :minimum => 6, :maximum => 20, :message => '密码长度必须为6~20位'
  validates_confirmation_of :password, :message => '两次输入的密码不相同'

  validates_presence_of :email, :message => '邮箱不能为空'
  validates_length_of :email, :maximum => 50, :message => '邮箱长度过长'
  validates_format_of  :email, :message => "邮箱格式不正确",
                       :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates_uniqueness_of :email, :case_sensitive => false, :message => '该邮箱已存在'


  # # getter、setter方法合并简写
  # attr_accessor :admin
  #
  # # 虚拟参数admin=的setter方法
  # def admin=(admin)
  #   @admin = admin
  #   if self.id != nil
  #     Admin.find_by_user_id self.id
  #   end
  # end

end
