class Rule
  def initialize(name, body)
    @name = name
    @body = body
  end

  def duplicate
    Rule.new @name, @body.duplicate
  end

  def infer_size
    @body.infer_size
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

  def matched
    @body.matched
  end

  def size_of
    @body.size_of
  end

  def to_s
    "#{@name}: #{@body}"
  end
end

