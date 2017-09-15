class Products::ShowSerializer < ActiveModel::Serializer
  attributes :name, :slug, :price, :shop_id, :quantity_stock, :description, :detail

  belongs_to :shop, serializer: Shops::ProductDetailSerializer
  has_many :product_images, serializer: Imagers::UrlSerializer
end
