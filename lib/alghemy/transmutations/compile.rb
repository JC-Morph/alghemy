require 'alghemy/affinities'
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
        @solution     = Affinities[:element] unless lmnt.dims
      end

      private

      def defaults
        asps = lmnt.inherit(%i[ext freq], :Sound)
        asps[:ext] ? asps : {ext: 'mp4'}
      end
    end
  end
end
