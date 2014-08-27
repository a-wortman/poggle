class ByteBody
  @base = 10
  def initialize(byte)
    @base = base_for(byte)
    @byte = value_for(byte, @base)
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

  def base_for(byte)
    if byte.start_with?("0x")
      16
    elsif byte.start_with?("b")
      2
    else
      10
    end
  end

  def to_s
    "Literal value #{@byte.to_s} [specified as #{@byte.to_s(@base)} base #{@base}]"
  end
end
