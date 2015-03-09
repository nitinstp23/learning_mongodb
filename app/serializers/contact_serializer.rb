class ContactSerializer < ActiveModel::Serializer
  attributes :telephone_number, :mobile_number, :fax_number

  belongs_to :user
end
