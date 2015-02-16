class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods

  rescue_from Mongoid::Errors::DocumentNotFound do |ex|
    render json: {parameters: ex.params, message: 'Document Not Found'}, status: :not_found
  end

  def current_user
    @current_user
  end

  protected

  def authenticate
    authenticate_token || render_unauthorized
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user = User.where(auth_token: token).first
    end
  end

  def render_unauthorized
    self.headers['WWW-Authenticate'] = 'Token realm="Application"'
    render json: 'Bad credentials', status: 401
  end
end
