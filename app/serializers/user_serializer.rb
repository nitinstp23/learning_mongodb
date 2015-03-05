class UserSerializer < ActiveModel::Serializer
  attributes :name, :email, :auth_token

  has_many :addresses

  # Skip association key if its value is blank ([])
  def associations
    hash = super

    hash.select { |k, v| v.present? }
  end
end
