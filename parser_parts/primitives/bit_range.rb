include Math
require_relative "../scope/scopifier"

class BitRange < Requirementless
  include Scopifier

  def initialize(low, high)
    @low_orig = low
    @high_orig = high

    @low = intify(low)
    @high = intify(high)

    if @low > @high
      throw "Low bound (#{@low}) must be below high (#{@high})"
    end

    @byte_count = high.length
  end

  def duplicate
    BitRange.new @low_orig, @high_orig
  end

  def intify(bit_str)
    value = 0
    for i in 0..bit_str.length - 1
      value = value * 2 + bit_str[i].to_i
    end
    value
  end

  def match(bytes)
    value = 0
    for i in 0..(@byte_count - 1)
      # little-endian
      # value = value * 2 + bytes.next

      # big-endian
      value = value + bytes.next_bit * (2**i)
    end

    value >= @low && value <= @high
  end

  def size_of
    Bytes.new ConstSize.new @byte_count
  end
end
