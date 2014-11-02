class BitBody
  def initialize(bits)
    @body = bits
  end

  def duplicate
    BitBody.new @body
  end

  def requirements
    []
  end

  def resolved
    true
  end

  def resolve(arg)
  end

  def match(bytes)
    for i in 0..@body.length
      if bytes.nextBit.to_s != @body[i]
        return false
      end
    end
    true
  end

  def to_s
    @body.to_s
  end
end
