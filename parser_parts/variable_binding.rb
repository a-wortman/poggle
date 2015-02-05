require_relative "./body_proxy"
require_relative "./scope/scopifier"

class VariableBinding < BodyProxy
  attr_accessor :name

  include Scopifier
  scopify :body

  def initialize(name, body)
    @name = name
    @body = body
  end

  def value
    @body.matched
  end

  def duplicate
    VariableBinding.new @name, @body
  end

  def bind
    @scope.bind(@name, self)
  end

  def to_s
    "('#{@name}', binding of #{@body})"
  end
end
