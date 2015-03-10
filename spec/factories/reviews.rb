FactoryGirl.define do

  factory :review do
    message { Faker::Lorem.word }
    rating { Faker::Number.digit }
    reviewed_by { '54f81d51736f771880000000' }
    product_id { create(:product) }
  end

end
