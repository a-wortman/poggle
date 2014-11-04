class AnyBytes
  def initialize(size)
    @size = Bytes.new ConstSize.new (size ? size : 1)
  end

  def duplicate
    AnyBytes.new @size.bytes
  end

  def requirements
    []
  end

  def resolve(arg)
  end

  def match(bytes)
    @data = []
    for i in 0..(@size.bytes-1)
      if bytes.eof
        return false
      else
        @data.unshift bytes.next
      end
    end
    true
  end

  def matched
    @data
  end

  def size_of
    @size
  end

  def resolved
    true
  end
end
