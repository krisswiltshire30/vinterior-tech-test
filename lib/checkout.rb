# frozen_string_literal: true

class Checkout
  attr_reader :basket, :total
  def initialize(basket = [], total = 0)
    @basket = basket
    @total = total
  end

  def scan(item)
    @basket << item
  end

  def total
    @basket.each do |item|
      @total += item[:price]
    end
    @total
  end
end
