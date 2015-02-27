# module for login with auth-token in controller specs
module SessionHelper
  def add_auth_token(auth_token)
    @request.headers['Authorization'] = "Token token=#{auth_token}"
  end
end

RSpec.configure do |config|
  config.include SessionHelper, type: :controller
end
