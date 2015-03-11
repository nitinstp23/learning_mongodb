class ReviewPolicy < ApplicationPolicy

  def create?
    record.product.user_id != user.id
  end

end
