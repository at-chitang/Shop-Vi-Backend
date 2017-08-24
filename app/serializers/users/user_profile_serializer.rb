class Users::UserProfileSerializer < ActiveModel::Serializer
  attributes :email, :first_name, :last_name, :birthday, :phone, :gender, :address, :province, :zipcode
end
