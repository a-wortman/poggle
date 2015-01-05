class AnyByte < Requirementless
  def initialize(size)
    @size = Bytes.new ConstSize.new 1
  end

  def duplicate
    AnyByte.new
  end

  def match(bytes)
    @data = bytes.next
    true
  end

  def matched
    @data
  end

  def size_of
    @size
  end
end
