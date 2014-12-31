require_relative '../requirementless'

class Eof < Requirementless
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
