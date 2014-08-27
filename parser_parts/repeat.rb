class Repeat
  def initialize(count, rule)
    @count = count
    @rule = rule
  end

  def to_s
    "(#{@count} instance of #{@rule})"
  end
end
