require_relative "./body_proxy"

class VariableBinding < BodyProxy
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

  def duplicate
    VariableBinding.new @name, @body
  end

  def to_s
    "('#{@name}', binding of #{@body})"
  end
end
