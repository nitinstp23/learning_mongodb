class API::ProductsController < ApplicationController
  before_action :authenticate

  def index
    products = current_user.products
                           .order(params[:order])
                           .page(params[:page])
                           .per(params[:per_page])

    render json: products
  end

  def create
    product = current_user.products.new(product_params)

    if product.save
      render json: product
    else
      render json: {product: {errors: product.errors}}, status: :internal_server_error
    end
  end

  def show
    product = Product.find(params[:id])
    product.add_view(current_user)

    render json: product
  end

  def update
    product = current_user.products.find(params[:id])

    if product.update(product_params)
      render json: product
    else
      render json: {product: {errors: product.errors}}, status: :internal_server_error
    end
  end

  def close
    product = Product.find(params[:id])
    product.update(availability: false)
    render json: product
  end


  private

  def product_params
    params.require(:product).permit(:name, :price, :availability)
  end
end
