class Contact
  include Mongoid::Document
  include Mongoid::Timestamps

  field :telephone_number, type: String
  field :mobile_number, type: String
  field :fax_number, type: String

  embedded_in :user

  validates :telephone_number, :mobile_number,:fax_number, presence: true
end
