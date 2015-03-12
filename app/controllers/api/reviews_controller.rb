class API::ReviewsController < ApplicationController
  before_action :authenticate

  def index
    render json: Review.where(review_index_params)
                       .order(params[:order])
                       .page(params[:page])
                       .per(params[:per_page])
  end

  def create
    product = Product.find(params[:id])
    review  = product.reviews.new(review_params)

    authorize(review)

    if review.save
      render json: review
    else
      render json: {review: {errors: review.errors}}, status: :internal_server_error
    end
  end

  private

  def review_params
    params.require(:review).permit(:message, :rating,:product_id, :reviewed_by)
  end

  def review_index_params
    {reviewed_by: params[:user_id], product_id: params[:product_id]}.compact
  end
end
