module Scopifier
  def self.included(base)
    base.extend Subthing
  end

  def enscopen(parent_scope)
    @scope = parent_scope.child

    # not sure how to just default to_enscopen to []...
    to_enscopen = self.class.to_enscopen || []

    to_enscopen.each { |name|
      instance_name = "@#{name}".to_sym
      instance_variable_get(instance_name)
        .tap { |rule|
          case rule
          when VariableBinding
            @scope.bind(rule)
          end
        }
        .enscopen(@scope)
    }
  end

  module Subthing
    attr_reader :to_enscopen

    def scopify(var, *rest)
      @to_enscopen = rest.unshift(var)
    end
  end
end

