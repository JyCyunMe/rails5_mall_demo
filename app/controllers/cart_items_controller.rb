class CartItemsController < ApplicationController
  # before_action :set_cart_item, only: [:show, :edit, :update, :destroy]
  include CurrentCart
  before_action :set_cart, only: [:update, :create, :refresh, :destroy]
  before_action :set_cart_item, only: [:update, :destroy]

  # GET /cart_items
  # GET /cart_items.json
  # def index
  #   @cart_items = CartItem.all
  #   # @cart_items = CartItem.find_by_cart_id(params[:cart_id]) unless nil || []
  # end

  # GET /cart_items/1
  # GET /cart_items/1.json
  # def show
  # end

  # GET /cart_items/new
  # def new
  #   @cart_item = CartItem.new
  # end

  # GET /cart_items/1/edit
  # def edit
  # end

  # 渲染首页购物车
  # POST /cart_items/1
  # POST /cart_items/1.json
  def refresh
    respond_to do |format|
      format.js
    end
  end

  # 添加商品到购物车
  # POST /cart_items
  # POST /cart_items.json
  def create
    product = Product.find(params[:product_id])
    @cart_item = @cart.add_product(product)

    respond_to do |format|
      if @cart_item.save
        format.json { render_ajax_success msg: '成功添加到购物车'}
        # format.html { redirect_to cart_url, notice: '成功添加到购物车' }
        # format.js
        # format.json { render :show, status: :created, location: @cart_item }
      else
        format.json { render_ajax_failure msg: '添加到购物车失败' }
        # format.html { render :new, notice: '添加到购物车失败' }
        # format.js
        # format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # 修改购物车商品信息（数量）
  # PATCH/PUT /cart_items/1
  # PATCH/PUT /cart_items/1.json
  def update
    respond_to do |format|
      if @cart_item.update(cart_params)
        format.html { redirect_to cart_url, notice: '购物车商品已修改' }
        format.json { render :show, status: :ok, location: @cart_item }
      else
        format.html { render :edit }
        format.json { render json: @cart_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # 删除购物车内的商品
  # DELETE /cart_items/1
  # DELETE /cart_items/1.json
  def destroy
    @cart_item.destroy
    respond_to do |format|
      if params[:_method] != 'delete'
        format.js
        format.json { render_ajax_success msg: '购物车商品已删除' }
        # format.json { head :no_content }
      else
        format.html { redirect_to cart_url, notice: '购物车商品已删除' }
        # format.js
        format.json { head :no_content }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_cart_item
    # @cart_item = CartItem.find_by(:cart_id => session[:cart_id], :product_id => params[:product_id])
    @cart_item = @cart.cart_items.find_by(:product_id => params[:product_id])
  end

  # Only allow a list of trusted parameters through.
  def cart_item_params
    params.require(:cart_item).permit(:product_id, :count || 1)
  end
end
