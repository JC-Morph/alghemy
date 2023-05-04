require 'alghemy/ancestors'
require 'alghemy/assistants'
require 'alghemy/methods'

module Alghemy
  module Transmutations
    # Public: Transmute Sound into Matter of a different affinity.
    class Visualise < Ancestors[:transmutation]
      include Assistants[:boots]
      include Methods[:alget]

      def tran_init
        return unless aural?
        def_ents
        stuff[:rate] ||= lmnt.rate
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric)
        rubric.t(:raw).r if raw?
        rubric.ents.input.t.ents.output
      end

      private

      def def_ents
        stuff[:enc] ||= [lmnt.arcana, alget(:encoding).first]
        stuff[:bit] ||= [lmnt.depth,  alget(:bitdepth).first]
      end

      def defaults
        {ext: ext_init}
      end

      # Internal: Default extension.
      def ext_init
        sijil = lmnt.inherit(:sijil, except: :Sound)
        sijil ? sijil.ext : '.raw'
      end
    end
  end
end
