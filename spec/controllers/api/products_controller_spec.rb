require 'rails_helper'

describe API::ProductsController do

  let(:user) do
    user = create(:user)
  end

  describe 'GET#index' do
    context 'with valid auth_token' do
      before do
        add_auth_token(user.auth_token)

        @product_1 = create(:product, name: 'Product 1')
        @product_2 = create(:product, name: 'Product 2')

        get :index
      end

      it 'responds with success' do
        expect(response.status).to eq(200)
      end

      it 'renders products list' do
        expected_json = {
          products: [
            {
              id: @product_1.id.to_s,
              name: @product_1.name,
              price: @product_1.price,
              availability: @product_1.availability
            },
            {
              id: @product_2.id.to_s,
              name: @product_2.name,
              price: @product_2.price,
              availability: @product_2.availability
            }
          ]
        }

        expect(response.body).to match_json_expression(expected_json)
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
    context 'with valid auth_token' do
      before do
        add_auth_token(user.auth_token)

        post :create, { product: { name: 'Product 1', price: 10.90, availability: false } }
      end

      it 'responds with success' do
        expect(response.status).to eq(200)
      end

      it 'creates a product' do
        product = Product.find_by(name: 'Product 1')

        expected_json = {
          product: {
            id: product.id.to_s,
            name: product.name,
            price: product.price,
            availability: product.availability
          }
        }

        expect(response.body).to match_json_expression(expected_json)
      end
    end

    context 'with invalid auth_token' do
      before do
        add_auth_token('invalid_auth_token')
        post :create, { product: { name: 'Product 1', price: 10.90, availability: false } }
      end

      it 'responds with unauthorized' do
        expect(response.status).to eq(401)
      end

      it 'renders error' do
        expect(response.body).to match_json_expression({errors: I18n.t['authentication.error']})
      end
    end
  end

  describe 'GET#show' do
    before do
      @product = create(:product, name: 'Product 1')
    end

    context 'with valid auth_token' do
      before do
        add_auth_token(user.auth_token)
        get :show, id: @product.id
      end

      it 'responds with success' do
        expect(response.status).to eq(200)
      end

      it 'returns the product' do
        expected_json = {
          product: {
            id: @product.id.to_s,
            name: @product.name,
            price: @product.price,
            availability: @product.availability
          }
        }

        expect(response.body).to match_json_expression(expected_json)
      end
    end

    context 'with invalid auth_token' do
      before do
        add_auth_token('invalid_auth_token')
        get :show, id: @product.id
      end

      it 'responds with unauthorized' do
        expect(response.status).to eq(401)
      end

      it 'renders error' do
        expect(response.body).to match_json_expression({errors: I18n.t['authentication.error']})
      end
    end
  end

  describe 'PUT#update' do
    before do
      @product = create(:product, name: 'Product 1', price: 10.9, availability: false)
    end

    context 'with valid auth_token' do
      before do
        add_auth_token(user.auth_token)
        put :update, id: @product.id, product: { name: 'Product 2', price: 20.9, availability: true }
      end

      it 'responds with success' do
        expect(response.status).to eq(200)
      end

      it 'updates the product' do
        expected_json = {
          product: {
            id: @product.id.to_s,
            name: 'Product 2',
            price: 20.9,
            availability: true
          }
        }

        expect(response.body).to match_json_expression(expected_json)
      end
    end

    context 'with invalid auth_token' do
      before do
        add_auth_token('invalid_auth_token')
        put :update, id: @product.id, product: { name: 'Product 2', price: 20.9, availability: true }
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
