require_relative './sizes/variable_size'

class Repeat
  def initialize(count, rule)
    @data = []
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
    end
    true
  end

  def duplicate
    Repeat.new @count, @rule.duplicate
  end

  def size_of
    puts @count

    case @count
    when VariableSize
      Bytes.new @count
    else
      @rule.size_of * @count.value
    end
  end

  def to_s
    "(#{@count} instance of #{@rule})"
  end
end
