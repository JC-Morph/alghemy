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
        cata[:enum] = :group_sijil
        @solution   = Affinities[:element] unless lmnt.dims
      end

      private

      def defaults
        rate = lmnt.inherit(:rate, except: :Sound)
        {ext: 'mp4', format: 'image2', rate: rate}
      end
    end
  end
end
