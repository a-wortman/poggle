class ReferenceSize
  def initialize(name, vars_context)
    @name = name
    @context = vars_context
  end

  def value
    if not @context[@name]
      raise "Variable #{@name} is undefined"
    end
    extractFor(@context[@name].value)
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
