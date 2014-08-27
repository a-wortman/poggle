class Components
  @@start_name = "root"

  @rules_by_name

  # TODO: figure out how to splat `rest` at the call site in poggler.rtlr. I want to have to do *rest.
  def initialize(first, rest)
    @rules_by_name = {}
    rest.unshift first
    @rules = rest
    @start = @rules.find { |rule|
      rule.name == @@start_name #@start_name
    }
    @rules.each { |rule|
      @rules_by_name[rule.name] = rule
    }
    if not @start
      raise "A start rule (named #{@@start_name}) must be defined"
    end

    link_dependencies

    if @start.resolved
      puts "TODO: Doing parse!"
    end
  end

  def link_dependencies
    last_requirements = @start.requirements
    while not @start.resolved
      @start.resolve(@rules_by_name)
      if @start.requirements == last_requirements
        raise "Cannot resolve rules: #{@start.requirements}"
      else
        last_requirements = @start.requirements
      end
    end
  end

  def to_s
    "foo"
  end
end

