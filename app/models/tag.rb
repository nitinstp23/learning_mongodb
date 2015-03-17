class Tag
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :name, type: String

  validates :name, presence: true, uniqueness: true
end
