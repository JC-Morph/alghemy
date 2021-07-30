require 'alghemy/ancestors'
require_relative 'mutypes/boots'

module Alghemy
  module Transmutations
    # Public: Transmute Sound into Matter of a different affinity.
    class Visualise < Ancestors[:transmutation]
      include Boots

      def tran_init
        ents = aural? ? lmnt_ents : stuff[:ents].flatten
        stuff[:ents].balance ents
        stuff[:ext]  ||= ext_init
        stuff[:rate] ||= lmnt.rate if aural?
      end

      def write_rubric
        rubric = write
        rubric.t(:raw).r if stuff[:raw]
        rubric.ents.input.t.ents.output
      end

      private

      # Internal: Default encoding and bitdepth.
      def lmnt_ents
        [lmnt.arcana, lmnt.depth]
      end

      # Internal: Default extension.
      def ext_init
        lmnt.inherit(:ext, except: :Sound) || '.raw'
      end
    end
  end
end
