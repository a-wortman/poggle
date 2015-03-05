require_relative '../requirementless'
require_relative '../scope/scopifier'

class AnyBytes < Requirementless
  include Scopifier

  def initialize(size)
    @data = []
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
      for i in 0..(@size.bytes-1)
        if bytes.eof
          return false
        else
          @data.unshift bytes.next
        end
      end
    when UnboundedSize
#      throw "***Learn how to handle an unbounded size!***"
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

  def to_j
    bytes_str = @data.map do |b|
      b.to_s(16)
    end
    "{\"type\": \"bytes\", \"value\": #{bytes_str}}"
  end
end
