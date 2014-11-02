class ConstSize
  def initialize(value)
    @value = value
  end

  def value
    @value
  end

  def to_s
    @value.to_s
  end

  def +(other)
    ConstSize.new(other.value + @value)
  end
end
