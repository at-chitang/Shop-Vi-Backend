class Orders::DetailSerializer < ActiveModel::Serializer
  attributes :quantity, :price

  belongs_to :product, serializer: Products::ListSerializer
  has_one :shop, serializer: Shops::ProductDetailSerializer
  has_one :product_image, serializer: Imagers::UrlSerializer
end
