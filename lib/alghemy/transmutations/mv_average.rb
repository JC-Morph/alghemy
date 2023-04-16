require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Take the average of motion vectors between frames
    class MvAverage < Ancestors[:transmutation]
      def rubric
        Rubrics[:ffedit]
      end

      def write_rubric( rubric = nil )
        write(rubric).input.func(:mv).script(:mv_average).output
      end

      private

      def defaults
        {ext: '.mpg'}
      end
    end
  end
end
