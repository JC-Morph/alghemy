require 'forwardable'

module Alghemy
  module Glyphs
    # Public: Represent information from previous Transmutations.
    class Memory
      extend Forwardable
      def_delegators :@aspects,
        :[],    :[]=,
        :each,  :select,
        :keys,  :values,
        :empty?
      attr_reader :aspects

      # Public: Override pretty_print to cleanup output in REPL.
      def pretty_print( pp )
        pp.pp aspects
      end

      def initialize( aspects )
        @aspects = aspects
      end

      # Public: Reorder mem for passing to a Transmutation as a reversion.
      def invert
        invertible = aspects.select  {|asp| %i[enc bit depth].any? asp }
        inverted = invertible.transform_values {|val| invert_array val }
        aspects.merge inverted
      end

      private

      def invert_array( arr )
        return arr unless arr.is_a? Array
        arr.reverse.map {|val| val.is_a?(Array) ? invert_array(val) : val }
      end
    end
  end
end
