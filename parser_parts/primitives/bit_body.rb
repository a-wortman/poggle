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
    for i in 0..@body.length - 1
      if bytes.next_bit.to_s != @body[i]
        return false
      end
    end
    true
  end

  def size_of
    Bits.new ConstSize.new @body.length
  end

  def to_s
    @body.to_s
  end
end
