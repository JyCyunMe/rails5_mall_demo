json.extract! product, :id, :title, :description, :image_url, :price, :count, :created_at, :updated_at
json.url product_url(product, format: :json)
