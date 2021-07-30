require 'alghemy/ancestors'
require 'alghemy/rubrics'

module Alghemy
  module Transmutations
    # Public: Crop a Sound.
    class Trim < Ancestors[:transmutation]
      def rubric
        Rubrics[:sox]
      end

      def write_rubric
        write.input.output.add trim
      end

      def trim
        ['trim', *parse_positions]
      end

      def parse_positions
        poss = %i[start pos end].map {|opt| stuff[opt] }.compact
        poss.prepend(0) if stuff[:end] && poss.size == 1
        poss.empty? ? [0, '-0'] : poss
      end

      private

      def defaults
        {ext: 'wav', label: 'T'}
      end
    end
  end
end
