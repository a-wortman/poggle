class ReferenceSize
  def initialize(name, vars_context)
    @name = name
    @context = vars_context
  end

  def value
    @context[@name]
  end

  def to_s
    if @context[@name]
      @context[@name].to_s
    else
      "undefined (variable: #{@name}) count"
    end
  end
end
