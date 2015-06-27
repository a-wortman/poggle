class Matcher
  attr_accessor :pointer
  def initialize(data)
    @bytes = data.bytes
    @marks = []
    @pointer = 0
    @bitPointer = 0
  end

  def peek
    @bytes[@pointer]
  end

  def next
    ret = @bytes[@pointer]
    @pointer += 1
    ret
  end

  def next_bit
    extract_from = @bytes[@pointer]
    bit = (extract_from >> (7 - @bitPointer)) & 1
    @bitPointer += 1
    if @bitPointer == 8
      @bitPointer = 0
      @pointer += 1
    end
    bit
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

  def forget
    @marks.shift
  end

  def reset
    revert
    mark
  end

  def to_s
    "Matcher for #{@bytes.length} bytes, pointer at #{@pointer}. #{@marks.count} marks counted."
  end

  def to_j
    "{\"byte\": #{@pointer}, \"bit\": #{@bitPointer}}"
  end
end
