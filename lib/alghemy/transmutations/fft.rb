require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Perform a fast fourier transform with image magick.
    class Fft < Ancestors[:transmutation]
      def rubric
        Rubrics[:fourier]
      end

      def tran_init
        @solution = Affinities[:elements]
      end

      private

      def defaults
        {ext: '.png'}
      end
    end
  end
end
