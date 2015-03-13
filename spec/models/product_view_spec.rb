require 'rails_helper'

RSpec.describe ProductView do

  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:product) }
  it { is_expected.to validate_presence_of(:user) }
end
