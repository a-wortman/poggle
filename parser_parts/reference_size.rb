class ReferenceSize
  def initialize(name, vars_context)
    @name = name
    @context = vars_context
  end

  def value
    if not @context[@name]
      raise "Variable #{@name} is undefined"
    end
    if @context[@name].value
      extractFor(@context[@name].value)
    else
      # this isn't matched yet, so the size is not concrete
      VariableSize.new
    end
  end

  def to_s
    if @context[@name]
      @context[@name].to_s
    else
      "undefined (variable: #{@name}) count"
    end
  end

  def extractFor(data)
    if data.length == 0
      raise "No value to extract, no function to extract data length == 0"
    elsif data.length == 1
      data[0]
    else
      raise "No function to extract data"
    end
  end
end
