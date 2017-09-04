require 'rails_helper'

RSpec.describe Product, type: :model do

  before do
    @category = Category.create(name: "Bikes")
    @product = Product.create(name: "Mountain Bike", quantity: 15, price: 150000, category: @category)
  end

  context "Validations:" do

    context "should be successful:" do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:category) }
      it { is_expected.to validate_presence_of(:price) }
      it { is_expected.to validate_presence_of(:quantity) }
    end

    context "should fail:" do
      before do
        @product.name = ""
        @product.save
      end

      it "errors out the right error" do
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end

    end

  end

end
