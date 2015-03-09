require 'rails_helper'

RSpec.describe Review do

  it { is_expected.to be_embedded_in(:product)}

  it { is_expected.to validate_presence_of(:message)}
  it { is_expected.to validate_presence_of(:rating)}
  it {is_expected.to validate_numericality_of(:rating)}

end

