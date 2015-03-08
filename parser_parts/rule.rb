require_relative './scope/scopifier'

class Rule < BodyProxy
  include Scopifier
  scopify :body

  def initialize(name, body)
    @name = name
    @body = body
    self.enscopen(Scope.new)
  end

  def duplicate
    Rule.new @name, @body.duplicate
  end

  # not so sure about this
  def enscopen(scope)
    @body.enscopen(scope)
  end

  def infer_size
    @body.infer_size
  end

  def match(bytes)
    @match_start = bytes.to_j
    @body.match(bytes).tap { |m| @match_end = bytes.to_j }
  end

  def name
    @name
  end

  def matched
    @body.matched
  end

  def to_s
    "#{@name}: #{@body}"
  end

  def to_j
    "{\"type\": \"rule\", \"name\": \"#{@name}\", \"size\": #{@body.size_j}, \"body\": #{@body.to_j}, \"position\": {\"start\": #{@match_start}, \"end\": #{@match_end}}}"
  end
end

