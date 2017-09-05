class Products::ListSerializer < ActiveModel::Serializer
  attributes :name, :slug, :price, :quantity_stock

  has_one :product_image, serializer: Products::GetUrlSerializer
end
