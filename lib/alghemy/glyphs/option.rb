module Alghemy
  module Glyphs
    # Public: Represents an option and appropriate value for an executable.
    class Option
      attr_reader :name, :hist, :flag, :prefix, :default, :shortcut, :no_space
      attr_accessor :value

      # Public: Initialise an Option.
      #
      # args - Hash of values that define the option's initial variables:
      #        flag     - Option in command-line format - flag that is used by
      #                   the executable.
      #        shortcut - Optional, shorter name that can be used to refer to
      #                   the option.
      #        default  - Default value for the option.
      def initialize( name, args = {} )
        args.each do |key, val|
          instance_variable_set("@#{key}", val)
        end
        @name = name
        @hist = []
        @flag  ||= name
        @value ||= default
      end

      def print( val = nil )
        val ||= increment_value
        return construct unless val && val != true
        hist << val
        construct val
      end

      def increment_value
        return value unless value.is_a? Array
        index = !hist.empty? && (value.size > 1) ? 1 : 0
        value[index]
      end

      def construct( val = nil )
        pre = construct_prefix
        pre = "#{pre}#{flag}"
        pre = nil if pre.empty?
        opt = [pre, val].compact
        no_space ? opt.join : opt
      end

      def construct_prefix
        return '-' unless prefix
        return prefix unless prefix.is_a?(Array)
        defined?(prefix.last) ? '+' : '-'
      end

      def has_value?( which )
        %i[name flag shortcut].any? {|id| which == send(id) }
      end
    end
  end
end
