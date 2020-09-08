require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Compile a Video from Images.
    class Compile < Ancestors[:transmutation]
      def rubric
        Rubrics[:fock]
      end

      def tran_init
        cata[:enum]   = :group_sijil
        cata[:format] = 'image2'
        @solution     = Element unless lmnt.dims
      end

      private

      def defaults
        asps = lmnt.inherit(%i[extype freq], :Sound)
        return {} unless asps[:extype]
        asps[:ext] = asps.delete(:extype).first
        asps
      end
    end
  end
end