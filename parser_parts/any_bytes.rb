class AnyBytes
  def initialize(size)
    @size = ConstSize.new Bytes.new (size ? size : 1)
  end

  def duplicate
    AnyBytes.new @size
  end

  def requirements
    []
  end

  def resolve(arg)
  end

  def match(bytes)
    @data = []
    for i in 0..@size.value-1
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

  def clone
    puts "Cloning!"
    AnyBytes.new size.value
  end

  def resolved
    true
  end
end
