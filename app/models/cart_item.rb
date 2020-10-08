class CartItem < ApplicationRecord
  # 外键关联，计数器缓存字段 count
  belongs_to :product, counter_cache: :count
  belongs_to :cart

  def total_price
    product.price * count
  end

end
