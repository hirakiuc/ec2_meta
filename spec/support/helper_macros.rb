module HelperMacros
  def instance_variable(object, key)
    object.instance_variable_get(key.intern)
  end
end
