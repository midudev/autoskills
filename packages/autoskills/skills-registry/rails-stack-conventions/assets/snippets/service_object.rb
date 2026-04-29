# Service object .call pattern
class CreateOrder
  def self.call(attrs)
    new(attrs).call
  end

  def initialize(attrs)
    @attrs = attrs
  end

  def call
    Order.create!(@attrs)
  end
end
