class VariableBinding
  def initialize(name, body)
    @name = name
    @body = body
    Components.vars[@name] = self
  end

  def value
    @body.matched
  end

  def resolved
    @body.resolved
  end

  def resolve(args)
    @body.resolve(args)
  end

  def match(bytes)
    @body.match(bytes)
  end

  def requirements
    @body.requirements
  end

  def duplicate
    VariableBinding.new @name, @body
  end

  def to_s
    "([#{@name}], binding of #{@body})"
  end
end
