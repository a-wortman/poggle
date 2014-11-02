class NumRule
  def initialize(num)
    @matchNum = num
    word_size = word_size @matchNum
    @bytes = [@matchNum].pack(size_for(word_size)).to_s.unpack("C"*word_size)
  end

  def size_for(size)
    case size
    when 1
      "C"
    when 2
      "S"
    when 4
      "L"
    when 8
      "Q"
    else
      throw "Unknown word size: #{size}"
    end
  end

  def word_size(num)
    # the [ , 1].max is to get around this deciding that
    # 0 needs 0 bytes to be represented.
    # [0, 256) => 1
    # [256, 65536) => 2
    # [65536, 2**32-1) => 4
    # [2**32, 2**64-1) => 8
    2 ** Math.log([(num.bit_length / 8.0).ceil, 1].max, 2).ceil
  end

  def duplicate
    NumRule.new @matchNum
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
    ConstSize.new Bytes.new @bytes.length
  end

  def match(bytes)
    for i in 0..@bytes.length
      if @bytes[i] != bytes.next
        return false
      end
    end
    true
  end

  def to_s
    "Value #{@matchNum} consisting of #{@bytes.length} bytes (#{@bytes.to_s})"
  end
end
