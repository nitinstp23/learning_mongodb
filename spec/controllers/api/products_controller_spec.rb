require 'rails_helper'

describe API::ProductsController do

  let(:user) do
    create(:user)
  end

  describe 'GET#index' do
    context 'with valid auth_token' do
      before do
        add_auth_token(user.auth_token)

        @product_1 = create(:product, name: 'Product 1', price: 10.90, user: user, tags_attributes: [ { name: 'tag 1' } ])
        @product_2 = create(:product, name: 'Product 2', price: 20.90, user: user, tags_attributes: [ { name: 'tag 2' } ])
        @product_3 = create(:product, name: 'Product 3', price: 30.90, user: user, tags_attributes: [ { name: 'tag 3' } ])
        @product_4 = create(:product, name: 'Product 4', price: 40.90, user: user, tags_attributes: [ { name: 'tag 4' } ])
      end

      it 'responds with success' do
        get :index

        expect(response.status).to eq(200)
      end

      it 'renders products list' do
        get :index

        expected_json = {
          products: [
            {
              id: @product_1.id.to_s,
              name: @product_1.name,
              price: @product_1.price,
              availability: @product_1.availability,
              tags:[
                {
                  name: @product_1.tags.first.name
                }
              ]
            },
            {
              id: @product_2.id.to_s,
              name: @product_2.name,
              price: @product_2.price,
              availability: @product_2.availability,
              tags:[
                {
                  name: @product_2.tags.first.name
                }
              ]
            },
            {
              id: @product_3.id.to_s,
              name: @product_3.name,
              price: @product_3.price,
              availability: @product_3.availability,
              tags:[
                {
                  name: @product_3.tags.first.name
                }
              ]
            },
            {
              id: @product_4.id.to_s,
              name: @product_4.name,
              price: @product_4.price,
              availability: @product_4.availability,
              tags:[
                {
                  name: @product_4.tags.first.name
                }
              ]
            }
          ]
        }

        expect(response.body).to match_json_expression(expected_json)
      end

      context 'with pagination and sorting' do
        it 'renders products list' do
          get :index, order: 'price desc', per_page: 2, page: 1

          expected_json = {
            products: [
              {
                id: @product_4.id.to_s,
                name: @product_4.name,
                price: @product_4.price,
                availability: @product_4.availability,
                tags:[
                  {
                    name: @product_4.tags.first.name
                  }
                ]
              },
              {
                id: @product_3.id.to_s,
                name: @product_3.name,
                price: @product_3.price,
                availability: @product_3.availability,
                tags:[
                  {
                    name: @product_3.tags.first.name
                  }
                ]
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
    context 'with valid auth_token' do
      before do
        add_auth_token(user.auth_token)

        post :create, { product: { name: 'Product 1', price: 10.90, availability: false, tags_attributes: [ { name: 'tag 1' } ] } }
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
            availability: product.availability,
            tags:[
              {
                name: product.tags.first.name
              }
            ]
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
      @product = create(:product, name: 'Product 1', user: user, tags_attributes: [ { name: 'tag 1'} ])
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
        viewed_at = @product.views.first.viewed_at
        expect(viewed_at).to eq viewed_at

        expected_json = {
          product: {
            id: @product.id.to_s,
            name: @product.name,
            price: @product.price,
            availability: @product.availability,
            tags:[
              {
                name: @product.tags.first.name
              }
            ]
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
      @product = create(:product, name: 'Product 1', price: 10.9, availability: false, user: user, tags_attributes: [ { name: 'tag 1'} ])
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
            availability: true,
            tags: [
              {
                name: @product.tags.first.name
              }
            ]
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


  describe 'GET#close' do
    before do
      @product = create(:product, name: 'product 1',user: user, availability: true, tags_attributes: [ { name: 'tag 1' } ])
    end

    context 'with valid auth token' do
      before do
        add_auth_token(user.auth_token)
        get :close, id: @product.id
      end

      it 'responds with success' do
        expect(response.status).to eq(200)
      end

      it 'returns the product' do
        expected_json = {
          product: {
            id: @product.id,
            name: @product.name,
            price: @product.price,
            availability: false,
            tags: [
              {
                name: @product.tags.first.name
              }
            ]
          }
        }

        expect(response.body).to match_json_expression(expected_json)
      end
    end

    context 'with invalid auth token' do
      before do
        add_auth_token('invalid auth token')
        get :close, id: @product.id
      end

      it 'reponds with unauthorized' do
        expect(response.status).to eq(401)
      end

      it 'renders error' do
        expect(response.body).to match_json_expression({errors: I18n.t['authentication.error']})
      end
    end

  end


end
