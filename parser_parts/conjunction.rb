class Conjunction
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

  def resolve(arg)
    @a.resolve(arg)
    @b.resolve(arg)
  end

  def to_s
    "(#{@a} followed by #{@b})"
  end
end
