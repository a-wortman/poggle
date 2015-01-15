require_relative '../requirementless'

class AnyBytes < Requirementless
  def initialize(size)
    @size = Bytes.new ConstSize.new (size ? size : 1)
  end

  def duplicate
    AnyBytes.new @size.bytes
  end

  def match(bytes)
    @data = []
    # and this is where we gotta handle
    # unbounded sizes...
    puts "size bytes type... #{@size.value.class}"
    puts "size bytes value type... #{@size.bytes.class}"
    case @size.value
    when ConstSize
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
