class Disjunction
  def initialize(a, b)
    @a = a
    @b = b
  end

  def resolved
    @a.resolved && @b.resolved
  end

  def requirements
    @a.requirements + @b.requirements
  end

  def to_s
    "(#{@a}, falling back to #{@b})"
  end
end
