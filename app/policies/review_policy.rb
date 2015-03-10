class ReviewPolicy

  attr_reader :user, :review

  def initialize(user,review)
    @user = user
    @review = review
  end

  def create?
    if review.present?
      not user.products.include?(review.product)
    end
  end
end
