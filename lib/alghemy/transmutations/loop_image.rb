require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Trims the first n seconds of a Video, then fades it in over the
    # last n seconds.
    class LoopImage < Ancestors[:transmutation]
      def self.priorities
        [:dur, :ext]
      end

      def self.expects
        with_plural :Image
      end

      def rubric
        Rubrics[:ffmpeg]
      end

      def write_rubric( rubric = nil )
        write(rubric).loop.input.dur.output
      end

      private

      def defaults
        {dur: 5, ext: 'mp4'}
      end
    end
  end
end
