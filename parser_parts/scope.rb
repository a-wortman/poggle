class Scope
  def initialize(parent = NilScope)
    @parent = parent
    @vars = {}
  end

  def get(name)
    if not @vars[name] # and parent == NilScope
      raise "No such variable '#{name}'"
    end
    # no looking in parent scopes... yet
    @vars[name] # || @parent.get(name)
  end

  def defined?(name)
    @vars.has_key?(name)
  end

  def bind(var_binding)
    name = var_binding.name
    if @vars[name]
      raise "Cannot rebind variable '#{name}'"
    end
    @vars[name] = var_binding
  end

  def child
    Scope.new(self)
  end
end
