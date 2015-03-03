class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :name, type: String
  field :price, type: Float
  field :availability, type: Boolean, default: true

  # embeds_many :instruments

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: true
end
