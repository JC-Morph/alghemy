require 'alghemy/ancestors'
require_relative 'mutypes/foot'

module Alghemy
  module Transmutations
    # Public: Transmute Sound into visual Matter.
    class Visualise < Ancestors[:transmutation]
      include Foot

      def tran_init
        ents = aural? ? lmnt_ents : cata[:ents].flatten
        cata[:ents].balance ents
        cata[:ext]  ||= ext_init
        cata[:rate] ||= lmnt.freq if aural?
      end

      def write_rubric
        rubric = write
        rubric.t(:raw).r if cata[:raw]
        rubric.ents.input.t.ents.output
      end

      private

      # Internal: Default encoding and bitdepth.
      def lmnt_ents
        [lmnt.arcana, lmnt.depth]
      end

      # Internal: Default extension.
      def ext_init
        extype = lmnt.inherit(:extype, :Sound)
        extype ? extype.first : '.raw'
      end
    end
  end
end
