class UserOrders::ListSerializer < ActiveModel::Serializer
  attributes :id, :receiver_name, :phone, :address, :province, :created_at, :total
end
