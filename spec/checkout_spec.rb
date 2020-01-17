# frozen_string_literal: true

require_relative '../lib/checkout.rb'

products = [
  { product_code: 001, name: 'Very Cheap Chair', price: 9.25 },
  { product_code: 002, name: 'Little table', price: 45.00 },
  { product_code: 003, name: 'Funky light', price: 19.95 }
]

describe 'Checkout' do
  before(:each) do
    @co = Checkout.new
  end
  context 'basket' do
    it 'Should add an item to the basket' do
      @co.scan(products[0])
      expect(@co.basket[0]).to eq(products[0])
    end
  end

  context 'total' do
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
end
