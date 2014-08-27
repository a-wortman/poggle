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
end
