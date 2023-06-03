require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Splits Image into separate grayscale images representing
    # colorspace components; by default these are Red, Blue, and Green.
    class SplitRgb < Ancestors[:transmutation]
      def self.expects
        with_plural :Image
      end

      def rubric
        Rubrics[:magick]
      end

      def tran_init
        @mult = true
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric).input.separate.output
      end

      private

      def defaults
        {ext: 'bmp', label: 'rgb'}
      end
    end
  end
end
