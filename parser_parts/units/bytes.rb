require_relative '../sizes/const_size'

class Bytes
  attr_accessor :size

  @@unit = "bytes"
  def self.unit
    @@unit
  end

  def unit
    @@unit
  end

  def initialize(size)
    @size = size || (ConstSize.new 1)
  end

  def value
    @size
  end

  def bytes
    @size.value
  end

  def bits
    @size.value * 8
  end

  def const
    @size.const
  end

  def +(other)
    return self unless const and other.const
    case other
    when Bytes
      Bytes.new ConstSize.new(bytes + other.bytes)
    when Bits
      Bits.new ConstSize.new(bits + other.bits)
    else
      throw "Unhandlable size #{other}"
    end
  end

  def *(other)
    Bytes.new(@size * other)
  end

  def to_s
    "#{@size} #{@@unit}"
  end
end
