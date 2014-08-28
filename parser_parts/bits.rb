class Bits
  @@unit = "bits"
  def self.unit
    @@unit
  end

  def unit
    @@unit
  end

  def initialize(size)
    @size = size
  end

  def value
    @size.value
  end
end
