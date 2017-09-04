require 'rails_helper'

RSpec.describe Review, type: :model do
  before do
    @category = Category.create(name: "Bikes")
    @product = Product.create(
      name: "Bike",
      price_cents: 15000,
      quantity: 10,
      category: @category
      )
    @user = User.create(
      first_name: 'Emanuel',
      last_name: 'Neves',
      email: "test@test.com",
      password: "12345678",
      password_confirmation: '12345678'
      )
    @review = Review.create(
      product: @product,
      rating: 4,
      user: @user
      )
  end

  context "Validations:" do

    it { is_expected.to validate_presence_of :product_id }
    it { is_expected.to validate_presence_of :user_id }
    it { is_expected.to validate_presence_of :rating }
    it { is_expected.to validate_numericality_of :rating }

  end

end
