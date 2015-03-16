class ProductView
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :product_id, type: BSON::ObjectId
  field :user_id, type: BSON::ObjectId
  field :viewed_at, type: DateTime, default: DateTime.now

  belongs_to :product
  belongs_to :user

  validates :product, presence: true
  validates :user, presence: true
end
