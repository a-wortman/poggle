class RuleReference
  def initialize(name)
    @name = name
  end

  def to_s
    "(Reference to rule #{@name})"
  end
end
