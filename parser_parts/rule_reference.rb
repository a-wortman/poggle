class RuleReference
  def initialize(name)
    @name = name
  end

  def resolve(rules)
    @rule = rules[@name]
    if not @rule
      puts "Improperly resolved! No rule #{@name}"
    elsif not resolved
      @rule.resolve(rules)
    end
  end

  def requirements
    if resolved
      []
    elsif @rule
      @rule.requirements
    else
      [@name]
    end
  end

  def resolved
    @rule != nil && @rule.resolved
  end

  def to_s
    "(Reference to rule #{@name})"
  end
end
