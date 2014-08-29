class VariableBinding
  def initialize(name, body)
    @name = name
    @body = body
    Components.vars[@name] = self
  end

  def value
    puts "Value: #{@body.matched}"
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
end
