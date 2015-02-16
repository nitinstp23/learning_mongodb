class API::SessionsController < ApplicationController

  def create
    user = User.find_by(email: user_params[:email])

    if user.authenticate(user_params[:password])
      render json: user
    else
      render json: {user: {errors: user.errors}}, status: :internal_server_error
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end

end
