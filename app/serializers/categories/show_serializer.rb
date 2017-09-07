class Categories::ShowSerializer < ActiveModel::Serializer
  attributes :name, :slug, :children
  has_many :children, class_name: Category.name, foreign_key: :parent_id,
                      serializer: Categories::ChildCategoriesSerializer
end
