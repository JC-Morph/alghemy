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
        rubric  = write(rubric).input
        rate    = stuff[:rate]
        seg_end = stuff[:span] - 1
        rubric.add("-filter_complex '
                   [0]segment=frames=1|#{seg_end}[s1][s2][s3];
                   [s1][s3]concat,nullsink;
                   [s2]reverse[r];
                   [0][r]concat,setpts=N/#{rate}/TB'")
        rubric.output
      end

      private

      def defaults
        {ext: 'mp4', label: 'Lr', rate: lmnt.rate, span: lmnt.span}
      end
    end
  end
end
