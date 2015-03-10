require 'spec_helper'

describe ReviewPolicy do
  subject { ReviewPolicy.new(user, review) }

  context "User can not review the products created by him" do
    let(:user) { FactoryGirl.create(:user) }
    let(:product) { FactoryGirl.create(:product) }
    let(:review) { nil }
    it { should_not permit(:create)  }
  end

  context "User can review the products created by other users" do
    let(:user) { FactoryGirl.create(:user) }
    let(:product) { FactoryGirl.create(:product) }
    let(:review) { FactoryGirl.create(:review) }
    it { should permit(:create)  }
  end

end
