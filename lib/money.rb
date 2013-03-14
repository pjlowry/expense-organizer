class Money
  def initialize(float_price)
    @price = float_price
  end

  def to_i
    (@price*100).to_i
  end

  def to_s
    "$%0.2f" % @price
  end

  def self.from_i(whole_number)
     "$%0.2f" % (whole_number.to_f/100)
  end
end
