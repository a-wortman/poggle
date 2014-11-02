class Prim
  def unit
    @unit
  end

  def initialize(u, size)
    @unit = u
    @size = size
  end

  def value
    @size.value
  end

  def to_s
    "$(length_of #{@unit})"
  end
end
