class ProductViewSerializer < ActiveModel::Serializer
  attributes :id, :product_id, :user_id, :viewed_at

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
end
