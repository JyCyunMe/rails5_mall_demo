class Cart < ApplicationRecord
  # 一对多关联，销毁自身时删除所有关联项
  has_many :cart_items, :dependent => :destroy

  # 添加商品，累加数量
  def add_product(product)
    current_item = cart_items.find_by(product_id: product.id)
    if current_item
      current_item.count += 1
    else
      current_item = cart_items.build(product_id: product.id, count: 1)
    end
    current_item
  end

  def total_count
    cart_items.to_a.sum { |item| item.count }
  end

  def total_price
    cart_items.to_a.sum { |item| item.total_price }
  end

end
