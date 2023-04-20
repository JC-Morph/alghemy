require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    class LoopReverse < Ancestors[:transmutation]
      def self.expects
        with_plural :Video
      end

      def rubric
        Rubrics[:ffmpeg]
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric).input
        rubric.add("-filter_complex '
                   [0]reverse[r];[0][r]concat,
                   setpts=N/#{stuff[:rate]}/TB'")
        rubric.output
      end

      private

      def defaults
        {ext: 'mp4', label: 'Lr', rate: lmnt.rate}
      end
    end
  end
end
