module Alghemy
  module Glyphs
    # Public: Represents an option and appropriate value for an executable.
    class Switch
      attr_reader   :label, :alias, :hist
      attr_accessor :default

      # Public: Initialise a Switch.
      #
      # arr - Array of values that define the switches initial variables.
      #       label   - Option in command-line format - flag that is used by the
      #                 executable.
      #       alias   - Alternative name for option that can be used to reference
      #                 switch.
      #       default - Default value for the option.
      def initialize( arr )
        @label, @alias, @default = *arr
        @hist = []
      end

      def print( val = nil )
        val ||= value
        return [] unless val
        hist << val
        structure val
      end

      def value
        return default unless default.is_a? Array
        index = !hist.empty? && (default.size > 1) ? 1 : 0
        default[index]
      end

      def structure( val )
        ["-#{label}", val]
      end
    end
  end
end
