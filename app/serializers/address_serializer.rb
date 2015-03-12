class AddressSerializer < ActiveModel::Serializer
  attributes :street, :city, :country
end
