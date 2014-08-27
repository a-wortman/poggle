class Rule
  def initialize(name, body)
    @name = name
    @body = body
  end

  def resolved
    @body.resolved
  end

  def requirements
    @body.requirements
  end

  def resolve(rules)
    @body.resolve(rules)
  end

  def name
    @name
  end

  def match(bytes)
    @body.match(bytes)
  end

  def to_s
    "#{@name}: #{@body}"
  end
end

