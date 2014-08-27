class Conjunction
  def initialize(a, b)
    @a = a
    @b = b
  end

  def to_s
    "(#{@a} followed by #{@b})"
  end
end
