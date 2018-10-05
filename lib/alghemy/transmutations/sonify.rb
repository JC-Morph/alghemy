require 'alghemy/ancestors'
require_relative 'mutypes/foot'

module Alghemy
  module Transmutations
    # Public: Transmute visual Matter into Sound.
    class Sonify < Ancestors[:transmutation]
      include Foot

      def tran_init
        cata[:ext] ||= '.wav'
      end

      def write_rubric
        rubric = write.type.rate.ents.input
        rubric.type(:raw) unless rubric.recognise?(cata[:ext])
        rubric.ents.output
      end
    end
  end
end
