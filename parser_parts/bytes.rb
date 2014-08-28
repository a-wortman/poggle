require_relative './const_size'

class Bytes
  @@unit = "bytes"
  def self.unit
    @@unit
  end

  def unit
    @@unit
  end

  def initialize(size)
    @size = size || ConstSize.new(1)
  end

  def value
    @size.value
  end
end
