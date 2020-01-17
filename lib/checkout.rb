# frozen_string_literal: true

class Checkout
  attr_reader :promotional_rules, :basket, :total
  def initialize(promotional_rules = [], basket = [], total = 0)
    @promotional_rules = promotional_rules
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
    promotion_checker
    @total
  end

  def promotion_checker
    @promotional_rules.each do |promo|
      multibuy(promo) if promo[:type] == 'multibuy'
    end
  end

  def multibuy(promo)
    @basket.each do |item|
      if item[:product_code] == promo[:product_code]
        item[:price] = promo[:price]
      end
    end
  end
end
