require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Extract Images from a Video.
    class Frames < Ancestors[:transmutation]
      def rubriclass
        Rubrics[:fock]
      end

      def tran_init
        cata[:glob] ||= frames_less_than(1_000) ? '%03d' : '%04d'
        cata[:freq] = lmnt.freq if lmnt.is_a?(Video)
        @solution = Affinities[:elements] unless frames_less_than 2
      end

      def write_rubric
        write.input.format('image2').vq.output
      end

      def anchors
        %i[freq]
      end

      private

      def defaults
        {ext: '.png'}
      end

      def frames_less_than( frames )
        lmnt.is_a?(Affinities[:video]) && lmnt.lifespan < frames
      end
    end
  end
end
