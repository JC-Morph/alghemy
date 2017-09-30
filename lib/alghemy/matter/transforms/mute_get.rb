# Module for retrieving Transmutant classes from symbols
module MuteGet
  # Return clss constant of name sym
  def mute_get( sym )
    clss.const_get sym.capitalize
  end

  # Namespace for constants
  def clss
    Transmutation
  end
end
