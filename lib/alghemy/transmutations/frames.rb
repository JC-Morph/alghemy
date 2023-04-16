require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Extract Images from a Video.
    class Frames < Ancestors[:transmutation]
      def self.expects
        with_plural :Video
      end

      def rubric
        Rubrics[:ffmpeg]
      end

      def tran_init
        span = lmnt.span
        pad  = span.to_s.size
        pad  = 2 if pad == 1
        stuff[:glob] ||= "%0#{pad}d"
        stuff[:rate]   = lmnt.rate
        @mult = true unless span < 2
      end

      def write_rubric( rubric = nil )
        write(rubric).input.format('image2').output
      end

      def anchors
        [:rate]
      end

      private

      def defaults
        {ext: '.png', label: 'frames'}
      end
    end
  end
end
