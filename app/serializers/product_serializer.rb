class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :availability
end
