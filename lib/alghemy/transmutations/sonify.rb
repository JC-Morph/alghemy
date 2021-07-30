require 'alghemy/ancestors'
require_relative 'mutypes/boots'

module Alghemy
  module Transmutations
    # Public: Transmute visual Matter into Sound.
    class Sonify < Ancestors[:transmutation]
      include Boots

      def tran_init
        stuff[:ext] ||= '.wav'
      end

      def write_rubric
        rubric = write.type.rate.ents.input
        rubric.type(:raw) unless rubric.recognise?(stuff[:ext])
        rubric.ents.output
      end
    end
  end
end
