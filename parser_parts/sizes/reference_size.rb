require_relative '../scope/scopifier'

class ReferenceSize
  include Scopifier

  def initialize(name)
    @name = name
  end

  def const
    # false in that this isn't const until parse-time.
    # false at gen-time.
    false
  end

  def defined?
    @scope.defined?(@name)
  end

  def value
    if not @scope.defined?(@name)
      raise "Variable #{@name} is undefined"
    end
    if @scope.get(@name).value
      extractFor(@scope.get(@name).value)
    else
      # this isn't matched yet, so the size is not concrete
      raise "Value for #{name} is not yet matched"
    end
  end

  def to_s
    return "SCOPE IS NOT SET" unless @scope

    if @scope.defined?(@name)
      @scope.get(@name).to_s
    else
      "undefined (variable: #{@name}) count"
    end
  end

  def extractFor(data)
    if data.length == 0
      raise "No value to extract, no function to extract data length == 0"
    elsif data.length == 1
      data[0]
    elsif data.length == 2
      # going with the big-endian interpretation because it matches class files for now.
      data[1] * 256 + data[0]
    elsif data.length == 4
      # ...
      ((data[3] * 256 + data[2]) * 256 + data[1]) * 256 + data[0]
    else
      raise "No function to extract data (#{data})"
    end
  end

  def self.e_f(data)
    if data.length == 0
      raise "No value to extract, no function to extract data length == 0"
    elsif data.length == 1
      data[0]
    elsif data.length == 2
      # going with the big-endian interpretation because it matches class files for now.
      data[1] * 256 + data[0]
    elsif data.length == 4
      # ...
      ((data[3] * 256 + data[2]) * 256 + data[1]) * 256 + data[0]
    else
      raise "No function to extract data (#{data})"
    end
  end
end
