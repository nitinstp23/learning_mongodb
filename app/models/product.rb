class Product
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :name, type: String
  field :price, type: Float
  field :user_id, type: BSON::ObjectId
  field :availability, type: Boolean, default: true

  belongs_to :user
  has_many :reviews
  has_many :product_views
  # embeds_many :instruments

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: true
  validates :user, presence: true
end
