require_relative '../requirementless'

class AnyBytes < Requirementless
  def initialize(size)
    @size = Bytes.new case size
    when ConstSize
      size
    when UnboundedSize
      size
    else
       ConstSize.new (size ? size : 1)
    end
  end

  def duplicate
    AnyBytes.new @size.value
  end

  def match(bytes)
    @data = []
    # and this is where we gotta handle
    # unbounded sizes...
    case @size.value
    when ConstSize
      puts @size.bytes.class
      for i in 0..(@size.bytes-1)
        if bytes.eof
          return false
        else
          @data.unshift bytes.next
        end
      end
    when UnboundedSize
      throw "***Learn how to handle an unbounded size!***"
    else
      raise "Don't know how to handle #{@size.value.class}"
    end
    true
  end

  def matched
    @data
  end

  def size_of
    @size
  end
end
