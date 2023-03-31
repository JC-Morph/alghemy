require 'forwardable'

module Alghemy
  module Properties
    # Public: Represents width and height for Elements with a spatial component.
    class Space
      extend Forwardable
      attr_reader :str, :width, :height
      alias x width
      alias y height
      delegate reduce: :dims

      # Public: Constructor. Parses space according to Class. Optionally uses
      # subspace to substitute missing dims.
      #
      # space    - A String, Array, or Integer, used as the basis for the Space.
      #            String  - Strings are unparsed. Expected format:
      #                      'heightxwidth'.
      #            Array   - Arrays can be one or two elements in size, and may
      #                      contain 0 at indexes to substitute with subspace.
      #            Integer - The width of the Space. Height will be provided by
      #                      subspace.
      # subspace - Array containing substitute values for the Space.
      def self.trace( space, subspace = [500, 500] )
        space = case space
                when String || self.class
                  space
                when Array
                  draw(space, subspace).join('x')
                when Integer
                  "#{space}x#{subspace[1]}"
                end
        new space || subspace
      end

      # Public: Build a 2-dimensional Array from two Arrays. Uses 0 as a
      # reference for substitution.
      #
      # arr    - Array expected to have at least one element. May contain 0 at
      #          indexes to be substituted.
      # subarr - Substitute Array. Expected to contain both width and height.
      #
      # Returns Array.
      def self.draw( arr, subarr = nil )
        return arr if subarr.nil?
        subarr.map.with_index do |dim, i|
          curr = arr[i]
          curr&.positive? ? curr : dim
        end
      end

      def pretty_print( pp )
        pp.pp str
      end

      def initialize( space )
        @str = space
        @width, @height = space.split('x').map(&:to_i)
      end

      # Public: Returns Array of dimensions.
      def dims
        [width, height]
      end

      # Public: Slice shortcuts for dimensions.
      #
      # Returns Integer of relevant dimension.
      def []( idx )
        return unless idx.is_a? Integer
        return width if idx.zero?
        height if idx == 1
      end

      # Public: Compares total number of pixels.
      def >( other )
        raise ArgumentError unless other.respond_to? :reduce
        reduce(:*) > other.reduce(:*)
      end
    end
  end
end
