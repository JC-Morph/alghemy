require 'alghemy/ancestors'
require 'alghemy/assistants'

module Alghemy
  module Transmutations
    # Public: Transmute visual Matter into Sound.
    class Sonify < Ancestors[:transmutation]
      include Assistants[:boots]

      def self.expects
        with_plurals %i[Element Image Video]
      end

      def write_rubric( rubric = nil )
        rubric = write(rubric).type.rate.ents.input
        rubric.type(:raw) unless rubric.recognise?(stuff[:ext])
        rubric.ents.output
      end
    end
  end
end
