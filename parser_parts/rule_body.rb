require_relative './any_bytes'
require_relative './any_bits'

class RuleBody
  def initialize(size, body)
    @size = size
    @body = body
    if not @body
      puts "No body present, size of data to match for this rule is #{@size}"
      if @size.unit == Bits.unit
        @body = AnyBits.new @size
      elsif @size.unit == Bytes.unit
        @body = AnyBytes.new @size
      else
        raise "Cannot handle unit #{@size.unit}"
      end
    end
    if not @size
      puts "Must infer a size for #{body}"
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

  def matched
    @body.matched
  end

  def to_s
    size = @size || "Unbounded"
    "#{@body.to_s} with size #{size}"
  end
end
