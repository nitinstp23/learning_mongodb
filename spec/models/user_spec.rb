require 'rails_helper'

RSpec.describe User do

  it { is_expected.to have_many(:products) }
  it { is_expected.to embed_many(:addresses) }
  it { is_expected.to embed_one(:home_contact)}
  it { is_expected.to embed_one(:office_contact)}

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_length_of(:password).greater_than(8).with_message("Password must be longer than 8 characters") }
  it { is_expected.to validate_confirmation_of(:password) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to custom_validate(:email).with_validator(EmailValidator) }

  it { is_expected.to validate_uniqueness_of(:email) }

  describe 'callbacks' do
    describe 'before_create' do
      it 'sets auth_token' do
        user = build(:user)
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
        password = ["", nil, []].sample
        user = build(:user, password: password)

        expect(user.password).to be_nil
        expect(user.password_hash).to be_nil
      end
    end

    context 'unencrypted_password parameter is not blank' do
      it 'sets password and password_hash' do
        unencrypted_password = 'password'
        user = build(:user, password: unencrypted_password)

        expect(user.password).to eq(unencrypted_password)
        expect(user.password_hash).to eq(BCrypt::Password.new(user.password_hash))
      end
    end
  end

  describe '#authenticate' do
    before do
      @unencrypted_password = 'password'
      @user = build(:user, password: @unencrypted_password)
    end

    context 'with correct password' do
      it 'return true' do
        expect(@user.authenticate(@unencrypted_password)).to eq(true)
      end
    end

    context 'with incorrect password' do
      it 'return false' do
        expect(@user.authenticate('wrong password')).to eq(false)
      end
    end
  end

end
