require_relative './const_size'

class Bytes
  @@unit = "bytes"
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
    case other
    when Bytes
      Bytes.new(@size + other.size)
    when Bits
      Bits.new(bit_size + other.size)
    else
      throw "Unhandlable size #{other}"
    end
  end

  def bit_size
    @size * 8
  end

  def size
    @size
  end

  def to_s
    "#{@size} #{@@unit}"
  end
end
