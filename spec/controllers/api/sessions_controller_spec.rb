require 'rails_helper'

describe API::SessionsController do

  let(:user) do
    create(:user)
  end

  describe 'POST#create' do
    context 'with valid credentials' do
      before do
        post :create, { email: user.email, password: user.password }
      end

      it 'responds with success' do
        expect(response.status).to eq(200)
      end

      it 'creates a user' do
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

    context 'with valid credentials' do
      before do
        post :create, { email: user.email, password: 'wrong password' }
      end

      it 'responds with unauthorized' do
        expect(response.status).to eq(500)
      end

      it 'renders error' do
        expect(response.body).to match_json_expression({error: 'Invalid email or password'})
      end
    end
  end

end
