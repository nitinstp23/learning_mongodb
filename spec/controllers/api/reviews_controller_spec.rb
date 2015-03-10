require 'rails_helper'

describe API::ReviewsController do

  let(:user) do
    create(:user)
  end

  describe 'POST#create' do

    before do
      @user = create(:user, name: "Test User", email: "test@example.com", password: "password")
      @product = create(:product, name: 'Product 1', price: 10.90, user: @user)
    end

    context 'with valid auth token' do
      before do
        add_auth_token(user.auth_token)
        post :create, { id: @product.id, review: { message: 'Good', rating: 2, product_id: @product.id, reviewed_by: user.id } }
      end

      it 'responds with success' do
        expect(response.status).to eq(200)
      end

      it 'creates a review' do
        review = Review.find_by(message: 'Good')

        expected_json = {
          review: {
            id: review.id,
            message: review.message,
            rating: review.rating,
            product_id: review.product_id,
            reviewed_by: review.reviewed_by
          }
        }

        expect(response.body).to match_json_expression(expected_json)
      end
    end

    context 'with invalid auth_token' do
      before do
        add_auth_token('invalid_auth_token')
        post :create, { id: @product.id, review: { message: 'Good', rating: 2, product_id: @product.id, reviewed_by: user.id } }
      end

      it 'responds with unauthorized' do
        expect(response.status).to eq(401)
      end

      it 'renders error' do
        expect(response.body).to match_json_expression({errors: I18n.t['authentication.error']})
      end
    end

  end

end
