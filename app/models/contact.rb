class Contact
  include Mongoid::Document
  include Mongoid::Timestamps

  field :telephone_number, type: String
  field :mobile_number, type: String
  field :fax_number, type: String

  embedded_in :user

  validates :telephone_number, :mobile_number,:fax_number, presence: true
  validates :telephone_number, format: { with: /\(?([0-9]{3})\)?([ .-]?)([0-9]{3})\2([0-9]{4})/ }
  validates :mobile_number,:fax_number, format: { with: /(\(\d{3}\)|\d{3})?\d{3}[- .]\d{4}/ }

end
