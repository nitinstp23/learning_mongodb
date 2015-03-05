require 'rails_helper'

RSpec.describe Address do

  it { is_expected.to be_embedded_in(:user) }

  it { is_expected.to validate_presence_of(:street) }
  it { is_expected.to validate_presence_of(:city) }
  it { is_expected.to validate_presence_of(:country) }

end
