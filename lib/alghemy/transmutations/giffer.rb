require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Replace a color in an image with an alpha channel.
    class Giffer < Ancestors[:transmutation]
      def self.priorities
        %i[posterize colors dither delay]
      end

      def rubric
        Rubrics[:magick]
      end

      def tran_init
        stuff[:enum] = :group_sijil
        @mult = false unless lmnt.dims
      end

      def write_rubric
        rubric = write.input
        add_priorities(rubric).output
      end

      private

      def defaults
        {dither: 'floydsteinberg', ext: 'gif'}
      end
    end
  end
end
