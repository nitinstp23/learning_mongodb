class ProductViewSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :user_id, :viewed_at, :product

  def id
    object.id.to_s
  end

  def product_id
    object.product_id.to_s
  end

  def user_id
    object.user_id.to_s
  end

  def viewed_at
    object.viewed_at.to_datetime.to_s
  end

  def product
    { id: object.product.id.to_s, name: object.product.name, price: object.product.price, availability: object.product.availability, user_id: object.product.user_id.to_s }
  end
end
