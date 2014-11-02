class NilScope
  def self.get(name)
    raise "Unbound variable \"#{name}\" being used"
  end

  def self.put(name, var)
    raise "Binding names to NilScope is a bug. Offender is \"#{name}\" with value \"#{var}\""
  end
end
