require_relative '../scope/scopifier'

class Mul
  include Scopifier
  scopify :a, :b

  def initialize(a, b)
    @a = a
    @b = b
  end

  def value
    @a.value * @b.value
  end

  def const
    @a.const && @b.const
  end
end
