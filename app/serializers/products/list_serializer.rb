class Products::ListSerializer < ActiveModel::Serializer
  attributes :name, :slug, :price, :quantity_stock

  has_many :product_images, serializer: Products::GetUrlSerializer
end
