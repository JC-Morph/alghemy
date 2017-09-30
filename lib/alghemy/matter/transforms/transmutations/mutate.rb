require_relative 'transmutation'
require_relative 'mutate/vst'

# Process Sound with VST effect plugins
class Mutate < Transmutation
  def rubriclass
    Mrs
  end

  def tran_init
    cata[:vst] = Vst.assert cata[:vst]
  end

  private

  def defaults
    {ext: lmnt.sijil.ext, label: '(M)', vst: Vst.list.sample}
  end
end
