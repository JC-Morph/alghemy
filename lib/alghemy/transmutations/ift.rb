require 'alghemy/ancestors'
require 'alghemy/affinities'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Perform an inverse fourier transform with image magick.
    class Ift < Ancestors[:transmutation]
      def rubriclass
        Rubrics[:fourier]
      end

      def tran_init
        cata[:enum] = :group
        @tome     = sub_tome if cata[:magni] || cata[:phase]
        @solution = Affinities[:element] if @tome.size == 2
      end

      private

      # Public: Define Tome (list of inputs) to be used. Parses inputs, which
      # may include explicit :magnitude or :phase images.
      def sub_tome
        tome = %i[magni phase].collect do |part|
          part = cata[part] || cata[:tome]
          part.is_a?(Array) ? part : part.list
        end.transpose
        tome.flatten! if tome.size == 1
        list tome
      end
    end
  end
end
