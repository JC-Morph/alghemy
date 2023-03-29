require 'alghemy/ancestors'
require 'alghemy/tomes'

module Alghemy
  module Tomes
    # Public: An indexed collection of Grimoires.
    class Metamoire < Ancestors[:tome]
      alias each_group each
      alias _transpose transpose

      # Public: Constructor method. Parses given Array according to dims,
      # & coerces Array elements into Grimoires. Preferred initialiser.
      def self.scribe( list, dims )
        groups = list.size / dims
        lmnts  = list.dup
        meta   = groups.times.with_object([]) do |_, arr|
          arr << lmnts.shift(dims)
        end
        new(meta).liberate
      end

      # Public: Converts all elements to Grimoires.
      def liberate
        collect {|arr| Tomes[:grimoire].scribe(arr) }
      end

      # Public: Transpose self, equivalent of Array#transpose.
      def transpose
        self.class.new(_transpose).liberate
      end

      # Public: Enumerator method for every element in elements.
      def each_lmnt( &block )
        return each {|grim| grim.each(&block) } if block_given?
        each.with_object([]) do |grim, arr|
          grim.each {|lmnt| arr << lmnt }
        end.to_enum
      end

      # Public: Returns the first lowest element.
      def first_lmnt
        place = __callee__.to_s[/^[a-z]+/]
        send(place).send(place)
      end
      alias last_lmnt first_lmnt

      def size
        entries.inject(0) {|size, tome| size + tome.size }
      end
    end
  end
end
