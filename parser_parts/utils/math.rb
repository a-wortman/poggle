module Math
  def word_size(num)
    # the [ , 1].max is to get around this deciding that
    # 0 needs 0 bytes to be represented.
    # [0, 256) => 1
    # [256, 65536) => 2
    # [65536, 2**32-1) => 4
    # [2**32, 2**64-1) => 8
    2 ** Math.log([(num.bit_length / 8.0).ceil, 1].max, 2).ceil
  end
end
