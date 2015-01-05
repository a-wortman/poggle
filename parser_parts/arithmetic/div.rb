class Div
  def initialize(a, b)
    @a = a
    @b = b
  end

  def value
    @a.value / @b.value
  end
end
