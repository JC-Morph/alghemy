require_relative 'transmutation'

# Concatenate Elements
class Append < Transmutation
  def tran_init
    cata[:enum]     = :group
    @solution = Element unless lmnt.dims
  end
end
