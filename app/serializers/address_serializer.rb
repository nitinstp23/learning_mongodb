class AddressSerializer < ActiveModel::Serializer
  attributes :street, :city, :country

  belongs_to :user
end
