class Review
  include Mongoid::Document
  include Mongoid::Timestamps

  field :message, type: String
  field :rating, type: Integer
  field :product_id, type: BSON::ObjectId
  field :reviewed_by, type: BSON::ObjectId

  belongs_to :product
  belongs_to :user

  validates :message, :rating, presence: true
  validates :rating, numericality: true
  validates :product, presence: true
  validates :reviewed_by, presence: true
end