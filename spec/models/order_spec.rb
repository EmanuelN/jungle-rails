require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'After creation' do
    before :each do
      @category = Category.create!(name: 'Bicycles')
      @product1 = Product.create!(name: "Mountain Bike", price: 100000, quantity: 10, category: @category)
      @product2 = Product.create!(name: "Street Bike", price: 250000, quantity: 20, category: @category)
      @order = Order.new(
        email: "test@test.com",
        total_cents: @product1.price,
        stripe_charge_id: '12461212499'
        )

      @order.line_items.new(
        product: @product1,
        quantity: 1,
        item_price: @product1.price,
        total_price: @product1.price
        )

      @order.save!

      @product1.reload
      @product2.reload

    end

    it 'order is successfully created' do
      expect(@order).to be_valid
    end

    it 'deducts quantity from products based on their line item quantities' do
      expect(@product1.quantity).to eq(9)
    end

    it 'does not deduct quantity from products that are not in the order' do
      expect(@product2.quantity).to eq(20)
    end
  end
end
