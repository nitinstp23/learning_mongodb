class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :message, :rating, :reviewed_by, :product_id

  def id
    object.id.to_s
  end

  def reviewed_by
    object.reviewed_by.to_s
  end

  def product_id
    object.product_id.to_s
  end
end
