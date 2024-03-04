require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Loop an Image for n seconds, creating a Video.
    class LoopImage < Ancestors[:transmutation]
      def self.priorities
        [:dur, :ext]
      end

      def self.expects
        :Image
      end

      def rubric
        Rubrics[:ffmpeg]
      end

      def write_rubric( rubric = nil )
        write(rubric).loop.input.dur.rate.output
      end

      private

      def defaults
        {dur: 3, ext: 'mp4'}
      end
    end
  end
end
