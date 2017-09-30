require_relative 'transmutation'
require_relative 'mutypes/foot'

# Transmute Sound into visual Matter
class Visualise < Transmutation
  include Foot

  def tran_init
    ents = aural? ? lmnt_ents : cata[:ents]
    cata[:ents].balance ents
    cata[:ext]  ||= ext_init
    cata[:rate] ||= lmnt.freq if aural?
  end

  private

  # Default encoding and bitdepth
  def lmnt_ents
    [lmnt.arcana, lmnt.depth]
  end

  # Default extension
  def ext_init
    extype = lmnt.inherit(:extype, :Sound)
    extype ? extype[0] : '.raw'
  end
end
