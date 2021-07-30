require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Replace a color in an image with an alpha channel.
    class Color2alpha < Ancestors[:transmutation]
      def self.priorities
        %i[color fuzz ext]
      end

      def rubric
        Rubrics[:magick]
      end

      def write_rubric
        write.input.fuzz.add("-transparent #{stuff[:color]}").output
      end

      private

      def defaults
        {color: :black, ext: 'png', label: 'c2a'}
      end
    end
  end
end
