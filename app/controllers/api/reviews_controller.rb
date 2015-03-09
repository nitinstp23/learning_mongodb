class API::ReviewsController < ApplicationController
  before_action :authenticate

  def create
    product = Product.find(params[:id])
    unless (product.user_id == current_user.id)
      review = product.reviews.new(review_params)

      if review.save
        render json: review
      else
        render json: {review: {errors: review.errors}}, status: :internal_server_error
      end

    else
      render json: {errors: "You can not review this product"}
    end
  end

  private
  def review_params
    params.require(:review).permit(:message, :rating,:product_id, :reviewed_by)
  end
end
