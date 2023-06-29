require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    class Bye < Ancestors[:transmutation]
      def rubric
        Rubrics[:byebyte]
      end

      def write_rubric( rubric = nil )
        mode   = stuff[:shuffle] ? :shuffle : :destroy
        rubric = write(rubric).send(mode).input.output
        %i[c C t times].each {|opt| rubric.send(opt) if stuff[opt] }
        rubric.chumin.chumax if mode == :shuffle
        rubric.min.max
      end
    end
  end
end
