# frozen_string_literal: true

require_relative '../lib/checkout.rb'

promotions = [
  { type: 'multibuy', product_code: 0o01, item_amount: 2, price: 8.50 },
  { type: 'discount_total', discount: 0.1, min_total: 60 }
]

products = [
  { product_code: 0o01, name: 'Very Cheap Chair', price: 9.25 },
  { product_code: 0o02, name: 'Little table', price: 45.00 },
  { product_code: 0o03, name: 'Funky light', price: 19.95 }
]

describe 'Checkout' do
  before(:each) do
    @co = Checkout.new(promotions)
  end
  context 'Basket' do
    it 'Should add an item to the basket' do
      @co.scan(products[0])
      expect(@co.basket[0]).to eq(products[0])
    end
  end

  context 'Total' do
    it 'Should have a starting basket total of zero' do
      @co = Checkout.new
      expect(@co.total).to eq(0)
    end

    it 'Should calculate the basket total' do
      @co.scan(products[0])
      @co.scan(products[1])
      expect(@co.total).to eq 54.25
    end
  end

  context 'Promotions' do
    it 'Should remove 0.75 from each chair if 2 or more chairs in basket' do
      @co.scan(products[0])
      @co.scan(products[0])
      @co.scan(products[2])
      expect(@co.total).to eq(36.95)
    end

    it 'Should apply a 10% discount if total above £60' do
      @co.scan(products[0])
      @co.scan(products[1])
      @co.scan(products[2])
      expect(@co.total).to eq(66.78)
    end

    it 'Should apply both promotions to total if applicable' do
      @co.scan(products[0])
      @co.scan(products[1])
      @co.scan(products[0])
      @co.scan(products[2])
      expect(@co.total).to eq(73.76)
    end
  end
end
