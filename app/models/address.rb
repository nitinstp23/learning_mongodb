class Address
  include Mongoid::Document
  include Mongoid::Timestamps

  field :street, type: String
  field :city, type: String
  field :country, type: String

  embedded_in :user

  validates :street, :city, :country, presence: true
end
