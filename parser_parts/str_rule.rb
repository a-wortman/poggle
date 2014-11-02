class StrRule
  def initialize(str)
    @matchStr = str
  end

  def duplicate
    StrRule.new @matchStr
  end

  def requirements
    []
  end

  def resolved
    true
  end

  def resolve(arg)
  end

  def size_of
    ConstSize.new Bytes.new @matchStr.length
  end

  def match(bytes)
    for i in 0..@matchStr.length - 1
      if bytes.eof
        return false
      else
        bytes.next == @matchStr[i]
      end
    end
    true
  end

  def to_s
    @matchStr
  end
end
