require_relative './primitives/any_bytes'
require_relative './primitives/any_bits'
require_relative './body_proxy'
require_relative './scope/scopifier'

class RuleBody < BodyProxy

  # consider yoinking this into BodyProxy
  include Scopifier
  scopify :body

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

  def to_j
    size_j = if @size == nil
               "{\"type\": \"unknown\"}"
             else
               @size.to_j
             end

    "{ \"size\": #{size_j}, \"body\": #{@body.to_j}}"
  end
end
