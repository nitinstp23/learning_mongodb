class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :auth_token

  has_many :addresses
  has_one :home_contact, class_name: "Contact"
  has_one :office_contact, class_name: "Contact"

  # Skip association key if its value is blank ([])
  def associations
    hash = super

    hash.select { |k, v| v.present? }
  end
end
