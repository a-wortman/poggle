require_relative '../requirementless'
require_relative '../scope/scopifier'

class BitBody < Requirementless
  include Scopifier

  def initialize(bits)
    @body = bits
  end

  def duplicate
    BitBody.new @body
  end

  def match(bytes)
    @match_start = bytes.to_j
    for i in 0..@body.length - 1
      if bytes.next_bit.to_s != @body[i]
        return false
      end
    end
    @match_end = bytes.to_j
    true
  end

  def size_of
    Bits.new ConstSize.new @body.length
  end

  def to_s
    @body.to_s
  end

  def to_j
    "{\"type\": \"bit_body\", \"value\": \"#{@body}\", \"position\": {\"start\": #{@match_start}, \"end\": #{@match_end}}}"
  end
end
