class Bits
  @@unit = "bits"
  def self.unit
    @@unit
  end

  def unit
    @@unit
  end

  def initialize(size)
    @size = size || 1
  end

  def value
    @size.value
  end

  def +(other)
    Bits.new (@size + other.bit_size)
  end

  def size
    @size
  end

  def bit_size
    @size
  end
end
