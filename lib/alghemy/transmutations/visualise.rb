require 'alghemy/ancestors'
require 'alghemy/methods'
require_relative 'mutypes/boots'

module Alghemy
  module Transmutations
    # Public: Transmute Sound into Matter of a different affinity.
    class Visualise < Ancestors[:transmutation]
      include Boots
      include Methods[:alget]

      def tran_init
        def_ents if aural?
        stuff[:ext]  ||= ext_init
        stuff[:rate] ||= lmnt.rate if aural?
      end

      def write_rubric
        rubric = write
        rubric.t(:is_raw).r if raw?
        rubric.ents.input.t.ents.output
      end

      private

      def def_ents
        stuff[:enc] ||= [lmnt.arcana, alget(:encoding).first]
        stuff[:bit] ||= [lmnt.depth,  alget(:bitdepth).first]
      end

      # Internal: Default extension.
      def ext_init
        sijil = lmnt.inherit(:sijil, except: :Sound)
        sijil ? sijil.ext : '.raw'
      end
    end
  end
end
