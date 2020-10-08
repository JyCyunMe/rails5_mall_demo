class Product < ApplicationRecord
  # rails 4+ 默认域
  # order 排序，where 条件
  default_scope { order(title: :desc, timestamp_attributes_for_create: :desc, timestamp_attributes_for_update: :desc) }

  has_many :cart_items
  # 在删除前调用该hook（如返回false则不删除）
  before_destroy :ensure_not_referenced_by_any_cart_item

  private

    def ensure_not_referenced_by_any_cart_item
      if cart_items.empty?
        return true
      else
        errors.add(:base, '购物车非空')
        return false
      end
    end

end
