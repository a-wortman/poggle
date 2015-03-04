require_relative './sizes/variable_size'
require_relative './scope/scopifier'

class Repeat

  include Scopifier
  scopify :rule, :count

  def initialize(count, rule)
    @matches = []
    @count = count
    @rule = rule
  end

  def resolved
    @rule.resolved
  end

  def requirements
    @rule.requirements
  end

  def resolve(arg)
    @rule.resolve(arg)
  end

  def match(bytes)
    for i in 1..@count.value
      repetition = @rule.match(bytes)
      if not repetition
        bytes.revert
        return false
      end
      @matches.push @rule.to_j # not sure if this works right.. think it does tho
    end
    true
  end

  def duplicate
    Repeat.new @count, @rule.duplicate
  end

  def size_of
    case @count
    when VariableSize
      Bytes.new @count
    else
      @rule.size_of * @count
    end
  end

  def to_s
    "(#{@count} instance of #{@rule})"
  end

  def to_j
    "{\"type\": \"repeat\", \"value\": [#{@matches.join(", ")}]}"
  end
end
