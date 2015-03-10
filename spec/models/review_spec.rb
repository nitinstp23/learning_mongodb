require 'rails_helper'

RSpec.describe Review do

  it { is_expected.to belong_to(:product) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:message) }

  it { is_expected.to validate_presence_of(:rating) }
  it { is_expected.to validate_numericality_of(:rating) }

  it { is_expected.to validate_presence_of(:product) }
  it { is_expected.to validate_presence_of(:reviewed_by) }

end
