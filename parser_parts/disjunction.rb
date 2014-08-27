class Disjunction
  def initialize(a, b)
    @a = a
    @b = b
  end

  def to_s
    "(#{@a}, falling back to #{@b})"
  end
end
