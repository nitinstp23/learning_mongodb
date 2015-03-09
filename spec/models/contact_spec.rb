require 'rails_helper'

RSpec.describe Contact do

  it { is_expected.to be_embedded_in(:user) }

  it { is_expected.to validate_presence_of(:telephone_number)}
  it { is_expected.to validate_presence_of(:mobile_number)}
  it { is_expected.to validate_presence_of(:fax_number)}

end
