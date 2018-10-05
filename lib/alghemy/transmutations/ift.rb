require 'alghemy/ancestors'
require 'alghemy/affinities'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Perform an inverse fourier transform with image magick.
    class Ift < Ancestors[:transmutation]
      def rubriclass
        Rubrics[:ffell]
      end

      def tran_init
        cata[:enum] = :group
        @tome     = sub_tome if cata[:magni] || cata[:phase]
        @solution = Affinities[:element] if @tome.size == 2
      end

      private

      # Public: Define Tome to be used.
      def sub_tome
        tome = %i[magni phase].collect do |lmnt|
          lmnt = cata[lmnt] || cata[:tome]
          lmnt.is_a?(Array) ? lmnt : lmnt.list
        end.transpose
        tome.flatten! if tome.size == 1
        list tome
      end
    end
  end
end
