class API::ProductsController < ApplicationController
  before_action :authenticate

  def index
    products = Product.order(params[:order])
                      .page(params[:page])
                      .per(params[:per_page])

    render json: products
  end

  def create
    product = Product.new(product_params)

    if product.save
      render json: product
    else
      render json: {product: {errors: product.errors}}, status: :internal_server_error
    end
  end

  def show
    render json: Product.find(params[:id])
  end

  def update
    product = Product.find(params[:id])

    if product.update(product_params)
      render json: product
    else
      render json: {product: {errors: product.errors}}, status: :internal_server_error
    end
  end

  private

  def product_params
    params.require(:product).permit(:name, :price, :availability)
  end
end
