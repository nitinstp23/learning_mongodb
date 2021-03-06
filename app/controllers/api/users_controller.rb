class API::UsersController < ApplicationController

  def create
    user = User.new(user_params)

    if user.save
      render json: user
    else
      render json: {user: {errors: user.errors}}, status: :internal_server_error
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, addresses_attributes: [:street, :city, :country], home_contact_attributes: [:telephone_number, :mobile_number, :fax_number],office_contact_attributes: [:telephone_number, :mobile_number, :fax_number])
  end

end
