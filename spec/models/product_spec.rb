require 'rails_helper'

RSpec.describe Product do

  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_numericality_of(:price) }

  it { is_expected.to validate_presence_of(:user) }

  describe "#add_view" do
    before do
      @user    = create(:user)
      @product = create(:product, { name: 'Product 1', price: '10.50', availability: true, user: @user })
    end

    context 'User views a product for the first time' do
      before do
        Timecop.freeze(Time.local(2015))
      end

      after do
        Timecop.return
      end

      it 'creates a view' do
        # test @product.views.find_by(user: @user).blank?
        expect(@product.views.where(user: @user).first).to be_nil
        # call @product.add_view(@user)
        @product.add_view(@user)
        # test @product.views. not blank
        view = @product.views.where(user: @user).first
        expect(view).to be_present
        # test @product.views.first.viewed_at current_time
        expect(view.viewed_at).to eq(Time.zone.now.to_datetime)
      end
    end

    context 'User views a product more than once' do
      before do
        Timecop.freeze(Time.local(2014))
      end

      after do
        Timecop.return
      end

      it 'updates a view' do
        # manually create pview
        product_view = @product.views.create(user: @user,viewed_at: Time.zone.now.to_datetime )
        # call
        @product.add_view(@user)
        # find @product.views.find_by(user: @user)
        view = @product.views.where(user_id: @user.id).first
        expect(view).to be_present
        # viewd_at current
        expect(view.viewed_at).to eq(Time.zone.now.to_datetime)
      end
    end
  end

end
