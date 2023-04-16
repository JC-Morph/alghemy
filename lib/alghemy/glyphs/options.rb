require 'forwardable'
require 'alghemy/glyphs'
require 'alghemy/methods'

module Alghemy
  module Glyphs
    # Public: Collection of commandline options for a utility.
    class Options
      extend Forwardable
      def_delegators :@list, :each, :values
      attr_reader :index, :list

      def initialize( templates, stuff = {} )
        @index = 0
        @list  = templates.each.with_object({}) do |(name, args), list|
          list[name] = Glyphs[:option].new(name, **args)
        end
        update! stuff
      end

      def increment_options( stuff )
        @index += 1
        update! stuff
      end

      def []( pseudonym )
        list.values.find {|option| option.known_as? pseudonym }
      end

      private

      def update!( stuff )
        values.each do |option|
          option.reset_index
          option.value = find_value(option, stuff)
        end
        self
      end

      def find_value( option, stuff )
        values = %i[name flag shortcut].map do |id|
          stuff[option.send(id)]
        end.compact
        return option.value if values.empty?
        get_current_value(values.first, option)
      end

      def get_current_value( value, option )
        return value unless value.is_a?(Array)
        return value if option.bi && !value.first.is_a?(Array)
        value.rotate(index).first
      end
    end
  end
end
