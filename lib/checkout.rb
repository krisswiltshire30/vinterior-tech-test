class Checkout
  attr_reader :basket, :total
  def initialize(basket = [], total = 0)
    @basket = basket
    @total = total
  end

  def scan(item)
    @basket << item
  end
end
