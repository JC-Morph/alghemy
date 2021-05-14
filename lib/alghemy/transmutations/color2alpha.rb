require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    class Color2alpha < Ancestors[:transmutation]
      def rubric
        Rubrics[:spell]
      end

      def write_rubric
        write.input.fuzz.add("-transparent #{cata[:color]}").output
      end

      private

      def defaults
        {color: :black, ext: 'png', label: 'c2a'}
      end
    end
  end
end
