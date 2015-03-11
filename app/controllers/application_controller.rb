class ApplicationController < ActionController::API
  include ActionController::Serialization
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include Pundit

  rescue_from Mongoid::Errors::DocumentNotFound do |ex|
    render json: {parameters: ex.params, message: I18n.t['database.errors.not_found']}, status: :not_found
  end

  rescue_from ActionController::UnpermittedParameters do |ex|
    render json: {parameters: ex.params, message: ex.message}, status: :bad_request
  end

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


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
    render json: {errors: I18n.t['authentication.error']}, status: 401
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    render json: {errors: I18n.t("#{policy_name}.#{exception.query}",scope: "pundit", default: :default)}, status: 401
  end
end
