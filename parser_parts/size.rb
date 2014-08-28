class Size
  def initialize(size_rule)
    @rule = size_rule
  end

  def value
    @rule.value
  end

  def to_s
    @rule.to_s
  end
end
