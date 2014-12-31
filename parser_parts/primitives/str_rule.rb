require_relative '../requirementless'

class StrRule < Requirementless
  def initialize(str)
    @matchStr = str
  end

  def duplicate
    StrRule.new @matchStr
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

  def size_of
    Bytes.new ConstSize.new @matchStr.length
  end

  def to_s
    @matchStr
  end
end
