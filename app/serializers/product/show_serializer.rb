class Product::ShowSerializer < ActiveModel::Serializer
  attributes :name, :price, :quantity_stock

  has_many :product_images, serializer: Product::GetUrlSerializer
end
