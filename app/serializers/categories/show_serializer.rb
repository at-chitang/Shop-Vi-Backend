class Categories::ShowSerializer < ActiveModel::Serializer
  attributes :name, :slug, :child_categories
  has_many :child_categories, class_name: Category.name, foreign_key: :parent_id,
                              serializer: Categories::ChildCategoriesSerializer
end
