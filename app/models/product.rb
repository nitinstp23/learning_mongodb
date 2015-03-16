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
  has_many :views, class_name: "ProductView"
  # embeds_many :instruments

  validates :name, :price, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: true
  validates :user, presence: true

  def add_view(user)
    product_view = ProductView.where(user_id: user, product_id: self).first_or_initialize do |pv|
      pv.viewed_at = Time.now
    end

    product_view.save
  end
end
