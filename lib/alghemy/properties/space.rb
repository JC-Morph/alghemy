require 'forwardable'
require 'alghemy/methods'

module Alghemy
  module Properties
    # Public: Represents width and height for Elements with spatial dimensions,
    # i.e Images and Videos.
    class Space
      extend Forwardable
      include Methods[:array_merge]
      attr_reader :to_s, :width, :height
      alias x width
      alias y height
      delegate split: :to_s
      def_delegators :dims, :join, :map, :reduce

      def pretty_print( pp )
        pp.pp to_s
      end

      def initialize( space, default = [500, 500] )
        @to_s = parse_space(space, default)
        @width, @height = split('x').map(&:to_i)
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

      # Public: Compares product of dimensions.
      #
      # Returns Boolean.
      def >( other )
        raise ArgumentError unless other.respond_to? :reduce
        reduce(:*).send(__callee__, other.reduce(:*))
      end
      alias < >

      private

      # Public: Parses input according to it's class. Uses default argument to
      # substitute values for missing dimensions.
      #
      # space   - A String, Array, or Integer, used as the basis for the Space.
      #           String  - Strings are unparsed. Expected format:
      #                     "#{width}x#{height}".
      #           Array   - Arrays can be one or two elements in size, and may
      #                     contain 0 at indexes to be substituted.
      #           Integer - The width of the Space. Height will be provided by
      #                     default.
      # default - Space or Array containing substitute values for the Space.
      def parse_space( space, default = [500, 500] )
        case space
        when self.class
          space.to_s
        when String
          space[/x/] ? space : parse_space(space.to_i, default)
        when Array
          arrays = [default.map(&:to_i), space.map(&:to_i)]
          array_merge(*arrays, ignore: 0)[0..1].join('x')
        when Integer
          space = 500 if space <= 0
          "#{space}x#{default[1]}"
        else
          default.join('x')
        end
      end
    end
  end
end
