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
        frames = lmnt.span
        return if frames < 2
        @mult = true
        pad   = [frames.to_s.size, 2].max
        stuff[:glob] ||= "%0#{pad}d"
      end

      def write_rubric( rubric = nil )
        write(rubric).input.format('image2').output
      end

      def anchors
        [:rate]
      end

      private

      def defaults
        {ext: '.png', label: 'frames', rate: lmnt.rate}
      end
    end
  end
end
