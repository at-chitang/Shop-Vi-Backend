class Carts::ShowSerializer < ActiveModel::Serializer
  attributes :quantity

  belongs_to :product, serializer: Products::ListSerializer
  has_one :shop, serializer: Shops::ProductDetailSerializer
  has_one :product_image, serializer: Imagers::UrlSerializer
end
