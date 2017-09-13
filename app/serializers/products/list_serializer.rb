class Products::ListSerializer < ActiveModel::Serializer
  attributes :name, :slug, :price, :quantity_stock

  belongs_to :shop, serializer: Shops::ProductDetailSerializer
  has_one :product_image, serializer: Imagers::UrlSerializer
end
