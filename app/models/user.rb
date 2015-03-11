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

  attr_reader :password

  has_many :products
  embeds_many :addresses, validate: false
  embeds_one :home_contact, class_name: "Contact"
  embeds_one :office_contact,  class_name: "Contact"
  has_many :reviews


  accepts_nested_attributes_for :addresses
  accepts_nested_attributes_for :home_contact
  accepts_nested_attributes_for :office_contact

  validates_presence_of :name
  validates :email, presence: true, email: true
  validates_uniqueness_of :email

  validate do |record|
    record.errors.add(:password, :blank) if record.password_hash.blank?
  end

  validates_length_of :password, minimum: 8, message: "Password must be longer than 8 characters"
  validates_confirmation_of :password, message: "Password confirmation must match given password"

  before_create :set_auth_token

  def password=(unencrypted_password)
    return if unencrypted_password.blank?

    @password = unencrypted_password
    self.password_hash = BCrypt::Password.create(unencrypted_password)
  end

  def authenticate(unencrypted_password)
    BCrypt::Password.new(self.password_hash) == unencrypted_password
  end

  private

  def set_auth_token
    self.auth_token = SecureRandom.uuid.gsub(/\-/, '_')
  end
end
