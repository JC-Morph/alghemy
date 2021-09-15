require 'forwardable'

module Alghemy
  module Glyphs
    # Public: Represent information from previous Transmutations.
    class Memory
      extend Forwardable
      def_delegators :@aspects, :[], :[]=, :select, :values, :empty?
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
        invertible = aspects.select  {|asp| %i[bit enc ents].any? asp }
        inverted   = invertible.each {|_, val| val.reverse! }
        aspects.merge inverted
      end
    end
  end
end
