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
    @total.round(2)
  end

  def promotion_checker
    @promotional_rules.each do |promo|
      if promo[:type] == 'multibuy'
        multibuy(promo)
      else promo[:type] == 'discount_total'
           discount_total(promo)
      end
    end
  end

  def multibuy(promo)
    discountable_items = @basket.select do |item|
      item[:product_code] == promo[:product_code]
    end

    if discountable_items.count >= promo[:item_amount]
      discountable_items.count.times do
        @total -= discountable_items[0][:price]
        @total += promo[:price]
      end
    end
  end

  def discount_total(promo)
    @total -= (@total * promo[:discount]) if @total >= promo[:min_total]
  end
end
