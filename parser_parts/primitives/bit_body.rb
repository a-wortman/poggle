require_relative '../requirementless'

class BitBody < Requirementless
  def initialize(bits)
    @body = bits
  end

  def duplicate
    BitBody.new @body
  end

  def match(bytes)
    puts "Matching bit body: " + @body
    for i in 0..@body.length - 1
      if bytes.next_bit.to_s != @body[i]
        return false
      end
    end
    puts "Done!"
    true
  end

  def size_of
    Bits.new ConstSize.new @body.length
  end

  def to_s
    @body.to_s
  end
end
