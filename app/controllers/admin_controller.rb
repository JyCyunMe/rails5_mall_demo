class AdminController < ApplicationController
  before_action :authorize_admin

  def index
    # @total_orders = Order.count
    @total_orders = 100
  end
end
