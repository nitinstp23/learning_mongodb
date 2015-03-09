require 'rails_helper'

describe API::UsersController do

  describe 'POST#create' do
    context 'with valid attributes' do
      context 'without address' do
        before do
          post :create, {
            user: {
              name: 'Nitin Misra',
              email: 'nitin@example.com',
              password: 'password',
              password_confirmation: 'password'
            }
          }
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

      context 'with address' do
        before do
          post :create, {
            user: {
              name: 'Nitin Misra',
              email: 'nitin@example.com',
              password: 'password',
              password_confirmation: 'password',
              addresses_attributes: [
                {
                  street: Faker::Address.street_name,
                  city: Faker::Address.city,
                  country: Faker::Address.country
                }
              ]
            }
          }
        end

        it 'responds with success' do
          expect(response.status).to eq(200)
        end

        it 'creates a user' do
          user    = User.find_by(email: 'nitin@example.com')
          address = user.addresses.first

          expected_json = {
            user: {
              name: user.name,
              email: user.email,
              auth_token: user.auth_token,
              addresses: [
                {
                  street: address.street,
                  city: address.city,
                  country: address.country
                }
              ]
            }
          }

          expect(response.body).to match_json_expression(expected_json)
        end
      end

      context 'with home contact' do
        before do
          post :create, {
            user: {
              name: 'Nitin Misra',
              email: 'nitin@example.com',
              password: 'password',
              password_confirmation: 'password',
              home_contact_attributes:
                {
                  telephone_number: Faker::PhoneNumber.phone_number,
                  mobile_number: Faker::PhoneNumber.cell_phone,
                  fax_number: Faker::PhoneNumber.cell_phone
                }

            }
          }
        end

        it 'responds with success' do
          expect(response.status).to eq(200)
        end

        it 'creates a user' do
          user    = User.find_by(email: 'nitin@example.com')
          home_contact = user.home_contact

          expected_json = {
            user: {
              name: user.name,
              email: user.email,
              auth_token: user.auth_token,
              home_contact:
                {
                  telephone_number: home_contact.telephone_number,
                  mobile_number: home_contact.mobile_number,
                  fax_number: home_contact.fax_number
                }

            }
          }

          expect(response.body).to match_json_expression(expected_json)
        end
      end

      context 'with office contact' do
        before do
          post :create, {
            user: {
              name: 'Nitin Misra',
              email: 'nitin@example.com',
              password: 'password',
              password_confirmation: 'password',
              office_contact_attributes:
                {
                  telephone_number: Faker::PhoneNumber.phone_number,
                  mobile_number: Faker::PhoneNumber.cell_phone,
                  fax_number: Faker::PhoneNumber.cell_phone
                }

            }
          }
        end

        it 'responds with success' do
          expect(response.status).to eq(200)
        end

        it 'creates a user' do
          user    = User.find_by(email: 'nitin@example.com')
          office_contact = user.office_contact

          expected_json = {
            user: {
              name: user.name,
              email: user.email,
              auth_token: user.auth_token,
              office_contact:
                {
                  telephone_number: office_contact.telephone_number,
                  mobile_number: office_contact.mobile_number,
                  fax_number: office_contact.fax_number
                }

            }
          }

          expect(response.body).to match_json_expression(expected_json)
        end
      end

    end

    context 'with invalid attributes' do
      before do
        post :create, {
          user: {
            name: 'Nitin Misra',
            email: 'nitin@example.com'
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
              password: ["can't be blank", "Password must be longer than 8 characters"]
            }
          }
        }

        expect(response.body).to match_json_expression(expected_json)
      end
    end
  end

end
