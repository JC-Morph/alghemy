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
        stuff[:label] = stuff[:chan].downcase
        @mult = true
      end

      def write_rubric( rubric = nil )
        write(rubric).input.chan.separate.output
      end

      private

      def defaults
        {chan: 'RGB', ext: 'bmp'}
      end
    end
  end
end
