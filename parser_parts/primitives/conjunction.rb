require_relative '../scope/scopifier'

class Conjunction
  include Scopifier
  scopify :a, :b

  def initialize(a, b)
    @a = a
    @b = b
  end

  def duplicate
    Conjunction.new @a.duplicate, @b.duplicate
  end

  def match(bytes)
    a_match = @a.match(bytes)
    if a_match
      b_match = @b.match(bytes)
      b_match
    else
      false
    end
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

  def size_of
    @a.size_of + @b.size_of
  end

  def to_s
    "(#{@a} followed by #{@b})"
  end
end
