class VariableBinding
  def initialize(name, body)
    @name = name
    @body = body
    if Components.vars[@name]
      raise "Variables cannot be bound more than once in the same scope! Offending variable is named \"#{@name}\""
    end

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

  def size_of
    @body.size_of
  end

  def duplicate
    VariableBinding.new @name, @body
  end

  def to_s
    "('#{@name}', binding of #{@body})"
  end
end
