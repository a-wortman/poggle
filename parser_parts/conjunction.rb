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

  def match(bytes)
    a_match = @a.match(bytes)
    if a_match
      b_match = @b.match(bytes)
      if not b_match
        bytes.revert
      end
      b_match
    else
      bytes.revert
      a_match
    end
  end

  def to_s
    "(#{@a} followed by #{@b})"
  end
end
