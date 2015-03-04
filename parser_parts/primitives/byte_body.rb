require_relative '../requirementless'
require_relative '../scope/scopifier'

class ByteBody < Requirementless
  include Scopifier

  @base = 10
  def initialize(byte)
    @orig_value = byte
    @base = base_for(byte)
    @byte = value_for(byte, @base)
  end

  def duplicate
    ByteBody.new val_s
  end

  def match(bytes)
    bytes.next == @byte
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

    value = val_str.to_i(base)
    if word_size(value) > 1
      raise "Byte body only allows values that can be expressed in one byte. Expected value is #{@orig_value}"
    end
    value
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

  def size_of
    Bytes.new ConstSize.new 1
  end

  def to_s
    "Literal value #{@byte.to_s} [specified as #{@byte.to_s(@base)} base #{@base}]"
  end

  def to_j
    "{\"type\": \"byte\", \"value\": \"#{@byte.to_s(16)}\"}"
  end
end
