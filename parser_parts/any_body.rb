# to support byte{_}:rule situations,
# need to try matching rule at every token extracted for unsized body

class AnyBody
  def initialize(size)
    @size = size
  end

  def resolved
    @size.concrete
  end

  def requirements
    @size.requirements
  end

  def resolve(arg)
    #??
  end

  def match(bytes)
    @data = []
    i = 0
    while i < @size.value
  end
