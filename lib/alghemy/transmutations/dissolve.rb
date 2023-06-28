require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    class Dissolve < Ancestors[:transmutation]
      def self.expects
        :bmp
      end

      def rubric
        Rubrics[:arss]
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric).input
        rubric.min.max.rate.pps
        [:brightness, :linear].each {|opt| rubric.send(opt) if stuff[opt] }
        rubric.send(stuff[:noise] ? :noise : :sine)
        rubric.output
      end

      def anchors
        [:size]
      end

      private

      def defaults
        {ext: 'wav'}
      end
    end
  end
end
