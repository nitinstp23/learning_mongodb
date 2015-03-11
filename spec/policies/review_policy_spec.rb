require 'rails_helper'

describe ReviewPolicy do

  subject { described_class }

  permissions :create? do
    context 'for products created by current user' do
      it 'should not permit' do
        user    = create(:user)
        product = create(:product, user: user)
        review  = build(:review, user: user, product: product)

        expect(subject).not_to permit(user, review)
      end
    end

    context 'for products created by other users' do
      it 'should permit' do
        user    = create(:user)
        product = create(:product)
        review  = build(:review, user: user, product: product)

        expect(subject).to permit(user, review)
      end
    end
  end

end
