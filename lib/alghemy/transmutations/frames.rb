require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Extract Images from a Video.
    class Frames < Ancestors[:transmutation]
      def rubriclass
        Rubrics[:ffmpeg]
      end

      def tran_init
        stuff[:glob] ||= frames_less_than(1_000) ? '%03d' : '%04d'
        stuff[:rate] = lmnt.rate if lmnt.is_a?(Video)
        @mult = true unless frames_less_than 2
      end

      def write_rubric
        write.input.format('image2').output
      end

      def anchors
        [:rate]
      end

      private

      def defaults
        {ext: '.png'}
      end

      def frames_less_than( frames )
        lmnt.is_a?(Affinities[:video]) && lmnt.span < frames
      end
    end
  end
end
