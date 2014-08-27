class Repeat
  def initialize(count, rule)
    @count = count
    @rule = rule
  end

  def resolved
    @rule.resolved
  end

  def requirements
    @rule.requirements
  end

  def resolve(arg)
    @rule.resolve(arg)
  end

  def to_s
    "(#{@count} instance of #{@rule})"
  end
end
