class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :availability

  def id
    object.id.to_s
  end
end
