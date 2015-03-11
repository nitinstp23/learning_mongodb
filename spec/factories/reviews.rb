FactoryGirl.define do

  factory :review do
    message { Faker::Lorem.word }
    rating { Faker::Number.digit }
    reviewed_by { create(:user) }
    product_id { create(:product) }
  end

end
