class ContactSerializer < ActiveModel::Serializer
  attributes :telephone_number, :mobile_number, :fax_number
end
