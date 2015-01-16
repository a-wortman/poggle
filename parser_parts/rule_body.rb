require_relative './primitives/any_bytes'
require_relative './primitives/any_bits'
require_relative './body_proxy'

class RuleBody < BodyProxy
  def initialize(size, body)
    @size = size
    @body = body
    if not @body
      case @size
      when Bits
        @body = AnyBits.new @size.value
      when Bytes
        @body = AnyBytes.new @size.value
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

  def matched
    @body.matched
  end

  def to_s
    size = @size || "Unbounded"
    "#{@body.to_s} with size #{size}"
  end
end
