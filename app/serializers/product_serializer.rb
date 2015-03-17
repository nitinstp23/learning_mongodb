class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :availability

  has_many :tags

  def id
    object.id.to_s
  end
end
