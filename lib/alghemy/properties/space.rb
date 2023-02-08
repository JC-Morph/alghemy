require 'forwardable'

module Alghemy
  module Properties
    # Public: 2-dimensional aspect for visual Elements, i.e. height x width.
    class Space < String
      extend Forwardable
      delegate :reduce => :dims

      # Public: Constructor. Parses space according to Class. Optionally uses
      # subspace to substitute missing dims.
      #
      # space    - A String, Array, or Integer, used as the basis for the Space.
      #            String  - Strings are unparsed. Expected format:
      #                      'heightxwidth'.
      #            Array   - Arrays can be one or two elements in size, and may
      #                      contain 0 at indexes to substitute with subspace.
      #            Integer - Expected to be the height of the Space. Width is
      #                      expected to be provided by subspace.
      # subspace - Sliceable duck to substitute for missing values in space.
      #            Expected to represent (or be) a valid Space.
      def self.trace( space, subspace = '500x500' )
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
      # subarr - Substitute Array or nil. If Array it is intended to contain
      #          enough elements to substitute missing or empty values in arr.
      #
      # Returns Array.
      def self.draw( arr, subarr )
        return arr if subarr.nil?
        space = arr.collect.with_index do |dim, i|
          dim.zero? ? subarr[i] : dim
        end
        space << subarr[1] if space.size == 1
        space
      end

      # Public: Returns Array of dimensions.
      def dims
        split('x').collect(&:to_i)
      end

      # Public: Slice shortcut for dimensions.
      #
      # Returns element in Array.
      def []( idx )
        return nil if idx.is_a?(Regexp)
        dims.slice({x: 0, y: 1}[idx.to_s.to_sym] || idx)
      end

      # Public: Comparison method. Compares reducable by product of elements,
      # i.e number of pixels.
      def >( other )
        raise ArgumentError unless other.respond_to? :reduce
        reduce(:*) > other.reduce(:*)
      end
    end
  end
end
