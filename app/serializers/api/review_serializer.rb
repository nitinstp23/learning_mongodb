class API::ReviewSerializer < ActiveModel::Serializer
  attributes :id, :message, :rating, :reviewed_by

end
