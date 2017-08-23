class Users::UserSerializer < ActiveModel::Serializer
  attributes :slug, :email, :auth_token
end
