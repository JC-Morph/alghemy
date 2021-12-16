require 'alghemy/affinities'
require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Trims the first n seconds of a Video, then fades it in over the
    # last n seconds.
    class Loopfade < Ancestors[:transmutation]
      def self.priorities
        [:fade, :ext]
      end

      def self.expects
        with_plural :Video
      end

      def rubric
        Rubrics[:ffmpeg]
      end

      def write_rubric
        fade      = stuff[:fade]
        fade_pts  = lmnt.len - (fade.to_i * 2)
        fade_vars = "duration=#{fade},format=yuva420p,fade=d=#{fade}"
        rubric = write.input.add("-filter_complex '
          [0]split[body][pre];
          [pre]trim=#{fade_vars}:alpha=1,setpts=PTS+(#{fade_pts}/TB)[jt];
          [body]trim=#{fade},setpts=PTS-STARTPTS[main];
          [main][jt]overlay
          '")
        rubric.output
      end

      private

      def defaults
        {ext: 'mp4', fade: 1, label: 'Lf'}
      end
    end
  end
end
