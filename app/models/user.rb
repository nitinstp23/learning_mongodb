require 'securerandom'
require 'bcrypt'

class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  # users.password_hash in the database is a :string
  include BCrypt

  field :name, type: String
  field :email, type: String
  field :password_hash, type: String
  field :auth_token, type: String

  attr_accessor :password, :password_confirmation

  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email
  # validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i, :message => "Please Enter a Valid Email Address."
  validates_length_of :password, :minimum => 8, :message => "Password Must Be Longer Than 8 Characters."
  validates_confirmation_of :password, :message => "Password Confirmation Must Match Given Password."

  before_create :set_auth_token

  def password
    @password ||= BCrypt::Password.new(self.password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = @password
  end

  def authenticate(user_password)
    password == user_password
  end

  private

  def set_auth_token
    self.auth_token = SecureRandom.uuid.gsub(/\-/, '_')
  end
end
