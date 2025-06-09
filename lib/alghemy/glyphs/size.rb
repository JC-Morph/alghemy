require 'forwardable'
require 'alghemy/methods'

module Alghemy
  module Glyphs
    # Public: Represents width and height for Elements with spatial dimensions,
    # i.e Images and Videos.
    class Size
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

      def initialize( size, default = [500, 500] )
        @to_s = parse_size(size, default)
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
      # size   - A String, Array, or Integer, used as the basis for the Size.
      #           String  - Strings are unparsed. Expected format:
      #                     "#{width}x#{height}".
      #           Array   - Arrays can be one or two elements in length, and may
      #                     contain 0 at indexes to be substituted.
      #           Integer - The width of the Size. Height will be provided by
      #                     default.
      # default - Size or Array containing substitute values for the Size.
      def parse_size( size, default = [500, 500] )
        case size
        when self.class
          size.to_s
        when String
          size[/x/] ? size : parse_size(size.to_i, default)
        when Array
          arrays = [default.map(&:to_i), size.map(&:to_i)]
          array_merge(*arrays, ignore: 0)[0..1].join('x')
        when Integer
          size = 500 if size <= 0
          "#{size}x#{default[1]}"
        else
          default.join('x')
        end
      end
    end
  end
end
