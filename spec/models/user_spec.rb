require 'rails_helper'

RSpec.describe User do

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_length_of(:password).greater_than(8).with_message("Password must be longer than 8 characters") }
  it { is_expected.to validate_confirmation_of(:password) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to custom_validate(:email).with_validator(EmailValidator) }

  it { is_expected.to validate_uniqueness_of(:email) }

  before do
    User.delete_all
  end

  describe 'callbacks' do
    describe 'before_create' do
      it 'sets auth_token' do
        user = User.new(name: 'Nitin', email: 'nitin@example.com', password: 'password')
        expect(user.auth_token).to be_nil

        user.save!
        user.reload
        expect(user.auth_token).not_to be_nil
      end
    end
  end

  describe '#password=' do
    context 'unencrypted_password parameter is blank' do
      it 'returns nil' do
        user = User.new(name: 'Nitin', email: 'nitin@example.com')
        user.password = ["", nil, []].sample
        expect(user.password).to be_nil
        expect(user.password_hash).to be_nil
      end
    end

    context 'unencrypted_password parameter is not blank' do
      it 'sets password and password_hash' do
        user = User.new(name: 'Nitin', email: 'nitin@example.com')
        unencrypted_password = 'password'
        user.password = unencrypted_password
        expect(user.password).to eq(unencrypted_password)
        expect(user.password_hash).to eq(BCrypt::Password.new(user.password_hash))
      end
    end
  end

  describe '#password_confirmation=' do
    it 'sets password_confirmation' do
      user = User.new(name: 'Nitin', email: 'nitin@example.com')
      unencrypted_password = 'password'
      user.password_confirmation = unencrypted_password
      expect(user.instance_variable_get(:@password_confirmation)).to eq(unencrypted_password)
    end
  end

  describe '#authenticate' do
    context 'with correct password' do
      it 'return true' do
        unencrypted_password = 'password'
        user = User.new(name: 'Nitin', email: 'nitin@example.com', password: unencrypted_password)
        expect(user.authenticate(unencrypted_password)).to eq(true)
      end
    end

    context 'with incorrect password' do
      it 'return false' do
        unencrypted_password = 'password'
        user = User.new(name: 'Nitin', email: 'nitin@example.com', password: unencrypted_password)
        expect(user.authenticate('wrong password')).to eq(false)
      end
    end
  end

end
