require 'rails_helper'

RSpec.describe Tag do

  it { is_expected.to be_embedded_in(:product) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

end
