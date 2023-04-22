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
                   [O0]segment=frames=1|#{seg_end}[s0][s1][s2];
                   [s0][s2]concat,nullsink;
                   [s1]reverse[rv];
                   [O0][rv]concat,setpts=N/#{rate}/TB'")
        rubric.output
      end

      private

      def defaults
        {ext: 'mp4', label: 'Lr', rate: lmnt.rate, span: lmnt.span}
      end
    end
  end
end
