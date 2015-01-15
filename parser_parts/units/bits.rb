class Bits
  attr_accessor :size

  @@unit = "bits"
  def self.unit
    @@unit
  end

  def unit
    @@unit
  end

  def initialize(size)
    @size = size || (ConstSize.new 1)
  end

  def type
    @size.class
  end

  def +(other)
    return other unless other.const
    Bits.new ConstSize.new (@size.force + other.bits)
  end

  def *(other)
    return other unless other.const
    Bits.new ConstSize.new (@size.force * other)
  end

  def const
    @size.const
  end

  def bits
    @size.force
  end

  def bytes
    raise "not a byte-sized value" if @size % 8 == 0
    @size.force / 8
  end
end
