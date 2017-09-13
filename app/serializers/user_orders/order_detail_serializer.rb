class UserOrders::OrderDetailSerializer < ActiveModel::Serializer
  attributes :total

  has_many :orders, serializer: Orders::DetailSerializer
  has_many :products, serializer: Products::ListSerializer
  has_many :shops, serializer: Shops::ProductDetailSerializer
end
