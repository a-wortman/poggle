class ByteBody
  @base = 10
  def initialize(byte)
    @base = base_for(byte)
    @byte = value_for(byte, @base)
  end

  def duplicate
    ByteBody.new val_s
  end

  def value_for(byte, base)
    val_str =
      if @base == 10
        byte
      elsif @base == 16
        byte[2..-1]
      elsif @base == 2
        byte[1..-1]
      end

    val_str.to_i(base)
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
    bytes.next == @byte
  end

  def base_for(byte)
    if byte.start_with?("0x")
      16
    elsif byte.start_with?("b")
      2
    else
      10
    end
  end

  def val_s
    prefix =
      if @base == 16
        "0x"
      elsif @base == 2
        "b"
      else
        ""
      end

    value = @byte.to_s(@base)

    "#{prefix}#{value}"
  end

  def to_s
    "Literal value #{@byte.to_s} [specified as #{@byte.to_s(@base)} base #{@base}]"
  end
end
