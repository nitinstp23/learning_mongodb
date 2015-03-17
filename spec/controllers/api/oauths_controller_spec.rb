require 'rails_helper'

describe API::OAuthsController do

  let(:oauth_token) { Faker::Lorem.characters(255) }

  describe 'POST#create' do
    before do
      allow_any_instance_of(FacebookApi).to receive(:get_me).and_return({'id' => '12345', 'name' => 'Nitin Misra', 'email' => 'nitin_misra@example.com'})
    end

    context 'with valid attributes' do
      before do
        post :create, {
          provider: 'facebook',
          user: {
            oauth_token: oauth_token,
            oauth_expires_at: DateTime.current
          }
        }
      end

      it 'responds with success' do
        expect(response.status).to eq(200)
      end

      it 'creates a user' do
        user = User.find_by(oauth_token: oauth_token)

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
        post :create, {
          provider: 'facebook',
          user: {
            oauth_expires_at: DateTime.current
          }
        }
      end

      it 'responds with unauthorized' do
        expect(response.status).to eq(500)
      end

      it 'renders error' do
        expected_json = {
          user: {
            errors: {
              oauth_token: ["can't be blank"]
            }
          }
        }

        expect(response.body).to match_json_expression(expected_json)
      end
    end
  end

end
