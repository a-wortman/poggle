require_relative './scope/scopifier'

class RuleReference
  include Scopifier

  def initialize(name)
    @name = name
  end

  def duplicate
    RuleReference.new @name
  end

  def resolve(rules)
    origRule = rules[@name]
    if not origRule
      raise "Undefined rule \"#{@name}\""
    end

    @rule = origRule.duplicate
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

  def matched
    @rule.matched
  end

  def match(bytes)
    @rule.match(bytes)
  end

  def size_of
    @rule.infer_size
    @rule.size_of
  end

  def to_s
    if not @rule
      "(Unresolved reference to rule #{@name})"
    else
      "(Ref: (#{@rule}))"
    end
  end
end
