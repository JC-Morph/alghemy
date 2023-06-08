require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Trims the first n seconds of a Video, then fades it in over the
    # last n seconds.
    class LoopFade < Ancestors[:transmutation]
      def self.priorities
        [:fade, :ext]
      end

      def self.expects
        with_plural :Video
      end

      def rubric
        Rubrics[:ffmpeg]
      end

      def write_rubric( rubric = nil )
        fade       = stuff[:fade]
        fade_pos   = lmnt.len - fade
        fade_chain = "trim=duration=#{fade},fade=d=#{fade}:alpha=1"

        rubric = write(rubric).input.add("-filter_complex '
          [0]split[s0][s1];
          [s0]trim=#{fade},setpts=PTS-STARTPTS[main];
          [s1]#{fade_chain},setpts=PTS+(#{fade_pos}/TB)[fade];
          [main][fade]overlay'")
        rubric.crf.output
      end

      private

      def defaults
        {crf: 10, ext: 'mp4', fade: lmnt.len * 0.3, label: 'Lf'}
      end
    end
  end
end
