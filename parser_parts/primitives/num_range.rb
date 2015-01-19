include Math

class NumRange < Requirementless
  def initialize(low, high)
    if low > high
      throw "Low bound (#{low}) must be below high (#{high})"
    end

    @low = low
    @high = high
    @byte_count = word_size(high)
  end

  def duplicate
    NumRange.new @low, @high
  end

  def match(bytes)
    value = 0
    for i in 0..(@byte_count - 1)
      # little-endian
      # value = value * 256 + bytes.next

      # big-endian
      value = value + bytes.next * (256**i)
    end

    value >= @low && value <= @high
  end

  def size_of
    Bytes.new ConstSize.new @byte_count
  end
end
