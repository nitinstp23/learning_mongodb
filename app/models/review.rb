class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :message, type: String
  field :rating, type: Integer
  field :product_id, type: BSON::ObjectId
  field :reviewed_by, type: BSON::ObjectId

  belongs_to :product
  belongs_to :user, foreign_key: :reviewed_by

  validates :message, :rating, presence: true
  validates :rating, numericality: true
  validates :product, presence: true
  validates :user, presence: true
end
