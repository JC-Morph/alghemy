require 'alghemy/data'
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
                    dict
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

      # Public: Set @index to -1.
      def reset_index
        @index = -1
      end

      # Public: Assign value.
      #
      # val - Value to assign to the option.
      def value=( val )
        val = [val].flatten.map do |contents|
          contents == 'rand' ? random : contents
        end
        val = val.first if val.size == 1
        @value = val
      end

      # Public: Get a random value from the option's boundaries.
      def random
        return value || default unless dict = find_dictionary
        return dict.sample if dict.is_a?(Array)
        rand(dict)
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

      # Public: Boolean if pseudonym matches an identifying variable.
      def known_as?( pseudonym )
        %i[name flag shortcut].any? {|id| pseudonym == send(id) }
      end

      private

      def find_dictionary
        return nil  unless dict
        return dict unless dict.is_a?(Array)
        Data[dict[0]].fetch(dict[1])&.keys || dict
      end

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
