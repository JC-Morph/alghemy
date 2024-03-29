require 'alghemy/methods'

module Alghemy
  module Glyphs
    # Public: Represents an option and appropriate value for an executable.
    class Option
      include Methods[:deep_clone]
      attr_accessor :value
      attr_reader(*%i[
                    index
                    name
                    hist
                    flag
                    default
                    bi
                    prefix
                    delim
                    shortcut
                  ])

      # Public: Initialise an Option.
      #
      # args - Hash of values that define the option's initial variables:
      #        flag     - Option in command-line format - flag that is used by
      #                   the executable.
      #        shortcut - Optional, shorter name that can be used to refer to
      #                   the option.
      #        default  - Default value for the option.
      def initialize( name, args = {} )
        reset_index
        set_arg_vars args
        @name = name
        @hist = []
        @flag  ||= name
        @value ||= deep_clone default
      end

      # Public: Discern and return next iteration of @value.
      def print( val = nil )
        val ||= increment_value
        hist << val
        val = nil if val == true
        construct val
      end

      # Public: Handle Array rotation for @value.
      def increment_value
        return value unless value.is_a?(Array)
        @index += 1
        value.rotate(index).first
      end

      # Public: Set @index to -1.
      def reset_index
        @index = -1
      end

      # Public: Boolean if pseudonym matches an identifying variable.
      def known_as?( pseudonym )
        %i[name flag shortcut].any? {|id| pseudonym == send(id) }
      end

      private

      # Internal: Set instance variables from key value pairs.
      def set_arg_vars( args )
        args.each do |key, val|
          instance_variable_set("@#{key}", val)
        end
      end

      # Internal: Construct a commandline representation of the option.
      def construct( val = nil )
        pre = "#{construct_prefix}#{flag}"
        pre = nil if pre.empty?
        opt = [pre, val].compact
        delim ? opt.join(delim) : opt
      end

      # Internal: Construct the correct flag prefix for the commandline.
      def construct_prefix
        return '-' unless prefix
        return prefix unless prefix.is_a?(Array)
        defined?(prefix.last) ? '+' : '-'
      end
    end
  end
end
