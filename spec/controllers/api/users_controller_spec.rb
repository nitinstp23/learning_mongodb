require 'rails_helper'

describe API::UsersController do

  describe 'POST#create' do
    context 'with valid attributes' do
      before do
        post :create, { user: { name: 'Nitin Misra', email: 'nitin@example.com', password: 'password', password_confirmation: 'password' } }
      end

      it 'responds with success' do
        expect(response.status).to eq(200)
      end

      it 'creates a user' do
        user = User.find_by(email: 'nitin@example.com')

        expected_json = {
          user: {
            name: user.name,
            email: user.email,
            auth_token: user.auth_token
          }
        }

        expect(response.body).to match_json_expression(expected_json)
      end
    end

    context 'with invalid attributes' do
      before do
        post :create, { user: { name: 'Nitin Misra', email: 'nitin@example.com' } }
      end

      it 'responds with unauthorized' do
        expect(response.status).to eq(500)
      end

      it 'renders error' do
        expected_json = {
          user: {
            errors: {
              password: ["can't be blank", "Password must be longer than 8 characters"]
            }
          }
        }

        expect(response.body).to match_json_expression(expected_json)
      end
    end
  end

end
