class Components
  @@start_name = "root"

  # TODO: figure out how to splat `rest` at the call site in poggler.rtlr. I want to have to do *rest.
  def initialize(first, rest)
    rest.unshift first
    @rules = rest
    @start = @rules.find { |rule|
      rule.name == @@start_name #@start_name
    }
    if not @start
      raise "A start rule (named #{@@start_name}) must be defined"
    end
  end

  def to_s
    "foo"
  end
end

