require_relative './any_bytes'
require_relative './any_bits'

class RuleBody
  def initialize(size, body)
    @size = size
    @body = body
    if not @body
      case @size
      when Bits
        @body = AnyBits.new @size.bits
      when Bytes
        @body = AnyBytes.new @size.bytes
      else
        raise "Cannot handle unit #{@size.unit}"
      end
    end
  end

  def infer_size
    if not @size
      @size = @body.size_of
    end
  end

  def duplicate
    RuleBody.new @size, @body.duplicate
  end

  def resolved
    @body.resolved
  end

  def requirements
    @body.requirements
  end

  def resolve(arg)
    @body.resolve(arg)
  end

  def match(bytes)
    @body.match(bytes.mark)
  end

  def size_of
    @body.size_of
  end

  def matched
    @body.matched
  end

  def to_s
    size = @size || "Unbounded"
    "#{@body.to_s} with size #{size}"
  end
end
