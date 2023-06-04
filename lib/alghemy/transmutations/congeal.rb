require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    class Congeal < Ancestors[:transmutation]
      def self.expects
        ['.bmp']
      end

      def rubric
        Rubrics[:arss]
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric).input
        rubric.min.max.rate.pps.brightness
        rubric.send(stuff[:noise] ? :noise : :sine)
        rubric.output
      end

      private

      def defaults
        {ext: 'wav'}
      end
    end
  end
end
