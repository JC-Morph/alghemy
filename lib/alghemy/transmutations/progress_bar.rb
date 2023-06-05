require 'alghemy/ancestors'
require 'alghemy/factories'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    class ProgressBar < Ancestors[:transmutation]
      def self.expects
        with_plural :Video
      end

      def rubric
        Rubrics[:ffmpeg]
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric).input.add("-filter_complex '
          color=c=#{stuff[:color]}:s=#{lmnt.size.x}x#{stuff[:bar_width]}[bar];
          [0][bar]overlay=-w+(w/#{lmnt.len})*t:H-h:shortest=1'")
        rubric.output
      end

      private

      def defaults
        super.merge(bar_width: 5, color: 'red')
      end
    end
  end
end
