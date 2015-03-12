class API::ReviewsController < ApplicationController
  before_action :authenticate

  def index
    if params[:user_id] && params[:product_id]
      reviews = Review.where(reviewed_by: params[:user_id],product_id: params[:product_id])
                      .order(params[:order])
                      .page(params[:page])
                      .per(params[:per_page])
    elsif params[:user_id]
      reviews = Review.where(reviewed_by: params[:user_id])
                      .order(params[:order])
                      .page(params[:page])
                      .per(params[:per_page])
    elsif params[:product_id]
      reviews = Review.where(product_id: params[:product_id])
                      .order(params[:order])
                      .page(params[:page])
                      .per(params[:per_page])
    else
      reviews = Review.all
                      .order(params[:order])
                      .page(params[:page])
                      .per(params[:per_page])
    end

    render json: reviews
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
end
