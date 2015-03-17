require 'rails_helper'

RSpec.describe User::AsSignUp do

  it { is_expected.to validate_length_of(:password).greater_than(8).with_message("Password must be longer than 8 characters") }
  it { is_expected.to validate_confirmation_of(:password) }

end
