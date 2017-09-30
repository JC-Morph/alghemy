require_relative 'transmutation'

# Compile a Video from Images
class Compile < Transmutation
  def rubriclass
    Ffock
  end

  def tran_init
    cata[:enum]     = :group_sijil
    cata[:format]   = 'image2'
    @solution = Element unless lmnt.dims
  end

  private

  def defaults
    asps = lmnt.inherit([:freq, :extype], :Sound)
    return {} unless asps[:extype]
    asps[:ext] = asps.delete(:extype).first
    asps
  end
end
