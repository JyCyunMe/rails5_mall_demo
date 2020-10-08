class UsersController < ApplicationController
  skip_before_action :authorize, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    # @users = User.all
    @users = User.order(:id, :user_name)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # User.find_by(name: 'test').try(:authenticate, 'mUc3m00RsqyRe') # => user
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    puts 123
    redirect_to mall_url if (session[:user_id] != nil)
    puts 456

    @user = User.new(user_register_params)

    respond_to do |format|
      unless verify_rucaptcha?(@user)
        format.html { render :new }
        format.json { render json: '验证码错误', status: :unprocessable_entity }
      else
        if @user.save
          format.html { redirect_to login_url,
                                    :alert => "用户 #{@user.user_name} (uid: #{@user.id}) 注册成功。" }
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|

      format.json { render json: '还未登录', status: :unprocessable_entity } if (session[:user_id] == nil)

      if @user.update(user_update_params)
        format.html { redirect_to polymorphic_url(@user),
                                  notice: "用户 #{@user.user_name} (uid: #{@user.id}) 修改信息成功。" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    respond_to do |format|
      format.json { render json: '还未登录', status: :unprocessable_entity } if (session[:user_id] == nil)

      @user.destroy
      format.html { redirect_to mall_path, notice: '永久注销账号成功' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    # @user = User.find(params[:id])
    @user = User.find(session[:user_id]['id'])
  end

  # Only allow a list of trusted parameters through.
  def user_register_params
    params.require(:user).permit(:user_name, :password, :password_confirmation, :email)
  end

  def user_update_params
    params.require(:user).permit(:id, :password, :password_confirmation, :email)
  end

end
