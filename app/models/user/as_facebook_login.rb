class User::AsFacebookLogin < User

  field :uid, type: String
  field :oauth_token, type: String
  field :oauth_expires_at, type: DateTime

  validates :oauth_token, :uid, :oauth_expires_at, presence: true

  before_validation :set_attributes!

  private

  def facebook_api
    @facebook_api ||= FacebookApi.new(self.oauth_token)
  end

  # raises Exceptions::OAuthError
  # if not able to fetch user details
  # from facebook graph API
  def set_attributes!
    details = facebook_api.get_me

    self.uid   = details['id']
    self.name  = details['name']
    self.email = details['email']

  rescue Koala::KoalaError => ex
    raise Exceptions::OAuthError.new(provider: 'facebook', message: ex.message)
  end

end
