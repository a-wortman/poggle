require_relative "../scope/scopifier"

class AnyBit < Requirementless
  include Scopifier

  def initialize
    @size = Bits.new ConstSize.new 1
  end

  def duplicate
    AnyBit.new
  end

  def match(bytes)
    @data = bytes.next_bit
    true
  end

  def matched
    @data
  end

  def size_of
    @size
  end
end
