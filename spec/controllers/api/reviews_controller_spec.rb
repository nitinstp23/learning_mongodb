require 'rails_helper'

describe API::ReviewsController do

  let(:current_user) do
    create(:user)
  end

  describe 'GET#index' do
    before do
      @user_1     = create(:user, name: "Test User 1", email: "user1@example.com", password: "password")
      @user_2     = create(:user, name: "Test User 2", email: "user2@example.com", password: "password")
      @product_1  = create(:product, name: 'Product 1', price: 10.20, user: @user_1)
      @product_2  = create(:product, name: 'Product 2', price: 10.20, user: @user_1)
      @review_1   = create(:review, message: 'Good', rating: 3, product: @product_1, reviewed_by: current_user)
      @review_2   = create(:review, message: 'Good', rating: 2, product: @product_2, reviewed_by: @user_2)
    end

    context 'with valid auth token' do
      before do
        add_auth_token(current_user.auth_token)
      end

      it 'responds with success' do
        get :index

        expect(response.status).to eq(200)
      end

      it 'renders review list' do
        get :index

        expected_json = {
          reviews: [
            {
              id: @review_1.id.to_s,
              message: @review_1.message,
              rating: @review_1.rating,
              product_id: @review_1.product_id.to_s,
              reviewed_by: @review_1.reviewed_by.to_s
            },
            {
              id: @review_2.id.to_s,
              message: @review_2.message,
              rating: @review_2.rating,
              product_id: @review_2.product_id.to_s,
              reviewed_by: @review_2.reviewed_by.to_s
            }
          ]
        }

        expect(response.body).to match_json_expression(expected_json)
      end

      context 'review for a user' do
        it 'renders review list' do
          get :index, user_id: current_user

          expected_json = {
            reviews: [
              {
                id: @review_1.id.to_s,
                message: @review_1.message,
                rating: @review_1.rating,
                product_id: @review_1.product_id.to_s,
                reviewed_by: @review_1.reviewed_by.to_s
              }
            ]
          }

          expect(response.body).to match_json_expression(expected_json)
        end
      end

      context 'review for a product' do
        it 'renders review list' do
          get :index, product_id: @product_1

          expected_json = {
            reviews: [
              {
                id: @review_1.id.to_s,
                message: @review_1.message,
                rating: @review_1.rating,
                product_id: @review_1.product_id.to_s,
                reviewed_by: @review_1.reviewed_by.to_s
              }
            ]
          }

          expect(response.body).to match_json_expression(expected_json)
        end
      end

      context 'review for both user and product' do
        it 'renders review list' do
          get :index, user_id: current_user, product_id: @product_1

          expected_json = {
            reviews: [
              {
                id: @review_1.id.to_s,
                message: @review_1.message,
                rating: @review_1.rating,
                product_id: @review_1.product_id,
                reviewed_by: @review_1.reviewed_by
              }
            ]
          }

          expect(response.body).to match_json_expression(expected_json)
        end
      end

      context 'with pagination and sorting' do
        it 'renders review list' do
          get :index, order: 'rating desc', per_page: 1, page: 1

          expected_json = {
            reviews: [
              {
                id: @review_1.id.to_s,
                message: @review_1.message,
                rating: @review_1.rating,
                product_id: @review_1.product_id.to_s,
                reviewed_by: @review_1.reviewed_by.to_s
              }
            ]
          }

          expect(response.body).to match_json_expression(expected_json)
        end
      end
    end

    context 'with invalid auth_token' do
      before do
        add_auth_token('invalid_auth_token')
        get :index
      end

      it 'responds with unauthorized' do
        expect(response.status).to eq(401)
      end

      it 'renders error' do
        expect(response.body).to match_json_expression({errors: I18n.t['authentication.error']})
      end
    end

  end

  describe 'POST#create' do
    before do
      @user = create(:user, name: "Test User", email: "test@example.com", password: "password")
      @product = create(:product, name: 'Product 1', price: 10.90, user: @user)
    end

    context 'with valid auth token' do
      before do
        add_auth_token(current_user.auth_token)
        post :create, { id: @product.id, review: { message: 'Good', rating: 2, product_id: @product.id, reviewed_by: current_user.id } }
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
        post :create, { id: @product.id, review: { message: 'Good', rating: 2, product_id: @product.id, reviewed_by: current_user.id } }
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
