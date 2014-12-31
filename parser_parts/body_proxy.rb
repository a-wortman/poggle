class BodyProxy
  def resolved
    @body.resolved
  end

  def resolve(args)
    @body.resolve(args)
  end

  def match(bytes)
    @body.match(bytes)
  end

  def requirements
    @body.requirements
  end

  def size_of
    @body.size_of
  end
end
