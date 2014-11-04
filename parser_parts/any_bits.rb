class AnyBits
  def initialize(size)
    @size = Bits.new ConstSize.new (size ? size : 1)
  end

  def match(bytes)
    @data = []
    idx = -1
    for i in 0..(@size.bits - 1)
      if i % 8 == 0
        idx += 1
        @data[idx] = 0
      else
        @data[idx] = @data[idx] << 1
      end
      @data[idx] |= bytes.next_bit
    end
    true
  end

  def resolved
    true
  end

  def duplicate
    AnyBits.new @size.bits
  end

  def requirements
    []
  end

  def resolve(arg)
  end

  def matched
    @data
  end

  def size_of
    @size
  end
end
