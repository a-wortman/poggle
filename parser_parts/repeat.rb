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
    puts "Matching #{@count.value}"
    for i in 1..@count.value
      puts "Matching repetition #{i}"
      @rule.match(bytes.mark)
    end
  end

  def to_s
    "(#{@count} instance of #{@rule})"
  end
end
