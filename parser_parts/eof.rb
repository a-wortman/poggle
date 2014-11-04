class Eof
  def match(bytes)
    bytes.eof
  end

  def requirements
    []
  end

  def resolve(rules)
  end

  def resolved
    true
  end

  def to_s
    "EOF"
  end

  def bits
    0
  end

  def bytes
    0
  end

  def size_of
    Bytes.new ConstSize.new 0
  end
end
