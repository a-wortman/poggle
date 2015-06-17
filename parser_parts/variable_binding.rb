require_relative "./body_proxy"
require_relative "./scope/scopifier"

class VariableBinding < BodyProxy
  attr_accessor :name

  include Scopifier
  scopify :body

  def initialize(name, body)
    @name = name
    @body = body
    @match_count = 0
  end

  def value
    @body.matched
  end

  def duplicate
    VariableBinding.new @name, @body
  end

  def match(bytes)
    @match_start = bytes.to_j
    matched = @body.match(bytes)
    @match_end = bytes.to_j
    @match_count = @match_count + 1
    matched
  end

  def bind
    @scope.bind(@name, self)
  end

  def to_s
    "('#{@name}', binding of #{@body})"
  end

  def to_j
    values_j = @body.matched.map do |b|
      "\"#{b.to_s(16)}\""
    end
    "{\"type\": \"variable\", \"id\": \"#{self.object_id}-#{@match_count}\", \"name\": \"#{@name}\", \"value\": [#{values_j.join(", ")}], \"num\": #{ReferenceSize.e_f(@body.matched)}, \"position\": {\"start\": #{@match_start}, \"end\": #{@match_end}}}"
  end
end
