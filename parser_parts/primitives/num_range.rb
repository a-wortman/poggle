require_relative '../scope/scopifier'

include Math

class NumRange < Requirementless
  include Scopifier

  def initialize(low, high)
    @low = convert(low)
    @high = convert(high)

    if low > high
      throw "Low bound (#{low}) must be below high (#{high})"
    end

    @byte_count = word_size(@high)
  end

  def duplicate
    NumRange.new @low, @high
  end

  def convert(value)
    case value
    when Fixnum
      value
    when String
      if value.start_with?("0x")
        value[2..-1].to_i(16)
      end
    else
      raise "Unable to handle value #{value} (#{value.class})"
    end
  end

  def match(bytes)
    value = 0
    for i in 0..(@byte_count - 1)
      # little-endian
      # value = value * 256 + bytes.next

      # big-endian
      value = value + bytes.next * (256**i)
    end

    @value = value
    value >= @low && value <= @high
  end

  def size_of
    Bytes.new ConstSize.new @byte_count
  end

  def to_j
    "{\"type\": \"num_range\", \"low\": #{@low}, \"high\": #{@high}, \"value\": \"#{@value}\"}"
  end
end
