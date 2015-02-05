require_relative '../requirementless'
require_relative '../scope/scopifier'

class Eof < Requirementless
  include Scopifier

  def match(bytes)
    bytes.eof
  end

  def to_s
    "EOF"
  end

  def size_of
    Bits.new ConstSize.new 0
  end
end
