class API::SessionsController < ApplicationController

  def create
    user = User.find_by(email: params[:email])

    if user.authenticate(params[:password])
      render json: user
    else
      render json: {user: {errors: user.errors}}, status: :internal_server_error
    end
  end

end
