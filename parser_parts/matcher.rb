class Matcher
  def initialize(data)
    @bytes = data.bytes
    @marks = []
    @pointer = 0
  end

  def next
    ret = @bytes[@pointer]
    @pointer += 1
    ret
  end

  def eof
    @pointer == @bytes.size
  end

  def mark
    @marks.unshift @pointer
    self
  end

  def revert
    @pointer = @marks.shift
  end

  def reset
    revert
    mark
  end

  def to_s
    "Matcher for #{@bytes.length} bytes, pointer at #{@pointer}. #{@marks.count} marks counted."
  end
end
