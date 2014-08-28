class Components
  @@start_name = "root"
  @@vars = {}

  def self.vars
    @@vars
  end

  @rules_by_name

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

  def match(bytes)
    if not @start
      raise "Start rule (#{@@start_name}) must be defined"
    end
    yes = @start.match(bytes)
    puts "Yes? #{yes}"
  end

  def to_s
    @start.to_s
  end
end

