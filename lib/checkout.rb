class Checkout
  attr_reader :basket
  def initialize(basket = [])
    @basket = basket
  end

  def scan(item)
    @basket << item
  end
end
