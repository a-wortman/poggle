class Scope
  def initialize(parent)
    @parent = parent || NilScope
    @vars = {}
  end

  def get(name)
    @vars[name] || @parent.get(name)
  end

  def put(name, var)
    @vars[name] = var
  end
end
