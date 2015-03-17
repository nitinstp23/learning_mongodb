class API::OAuthsController < ApplicationController

  before_action :get_provider

  rescue_from Exceptions::OAuthError do |ex|
    render json: {provider: ex.provider, message: ex.message}, status: :internal_server_error
  end

  def create
    user = @provider.new(user_params)

    if user.save
      render json: user, root: :user, serializer: UserSerializer
    else
      render json: {user: {errors: user.errors}}, status: :internal_server_error
    end
  end

  private

  PROVIDERS = {
    facebook: User::AsFacebookLogin
    # other providers...
  }.with_indifferent_access

  def user_params
    params.require(:user).permit(:oauth_token, :oauth_expires_at)
  end

  def get_provider
    @provider = PROVIDERS.fetch(params[:provider])
  rescue KeyError => ex
    render_provider_not_found
  end

  def render_provider_not_found
    render json: {error: { message: "OAuth provider: #{params[:provider]} not found" }}, status: :not_found
  end

end
