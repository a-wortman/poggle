class Components
  @@start_name = "root"
  @rules_by_name

  def initialize(first, rest)
    @debug = false

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
    infer_sizes
    check_sizes
    @rules_by_name["root"].enscopen(Scope.new)
  end

  def unresolved_dependencies
    @rules.each { |rule|
      if not rule.resolved
        return true
      end
    }
    false
  end

  def infer_sizes
    @rules.each { |rule|
      if @debug
        puts "Inferring size for #{rule}"
      end
      rule.infer_size
    }
  end

  def check_sizes
  end

  def link_dependencies
    while unresolved_dependencies
      stuck = true
      @rules.each { |rule|
        last_reqs = rule.requirements
        rule.resolve(@rules_by_name)
        stuck &= last_reqs == rule.requirements
      }
      if stuck
        throw "In resolution loop"
      end
    end
  end

  def match(bytes)
    if not @start
      raise "Start rule (#{@@start_name}) must be defined"
    end
    @start.match(bytes)
  end

  def to_s
    @start.to_s
  end
end

