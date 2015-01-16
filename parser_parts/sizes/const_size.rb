class ConstSize
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def force
    self
  end

  def const
    true
  end

  def to_s
    @value.to_s
  end

  def +(other)
    return other unless other.const # is knowable perhaps a better word?
    ConstSize.new(other.value + @value)
  end

  def *(other)
    return other unless other.const
    ConstSize.new(other.value * @value)
  end
end
