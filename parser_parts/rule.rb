class Rule
  def initialize(name, body)
    @name = name
    @body = body
  end

  def name
    @name
  end

  def to_s
    "#{@name}: #{@body}"
  end
end

