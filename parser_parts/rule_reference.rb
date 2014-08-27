class RuleReference
  def initialize(name)
    @name = name
  end

  def resolve(ref)
    @rule = ref
  end

  def requirements
    if resolved
      []
    else
      [@name]
    end
  end

  def resolved
    @rule != nil
  end

  def to_s
    "(Reference to rule #{@name})"
  end
end
