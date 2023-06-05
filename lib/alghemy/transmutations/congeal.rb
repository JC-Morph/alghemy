require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    class Congeal < Ancestors[:transmutation]
      def self.expects
        with_plural :Sound
      end

      def rubric
        Rubrics[:arss]
      end

      def tran_init
        height = lmnt.inherit(:size)&.y
        stuff[:height] ||= height || 500
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric).input
        rubric.min.max.height.pps
        [:brightness, :linear].each {|opt| rubric.send(opt) if stuff[opt] }
        rubric.output
      end

      private

      def defaults
        {ext: 'bmp'}
      end
    end
  end
end
