class ConstSize
  def initialize(value)
    @value = value
  end

  def force
    @value
  end

  def const
    true
  end

  def to_s
    @value.to_s
  end

  def +(other)
    return other unless other.const
    ConstSize.new(other.value + @value)
  end

  def *(other)
    return other unless other.const
    ConstSize.new(other.value * @value)
  end
end
