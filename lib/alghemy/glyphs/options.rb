require 'forwardable'
require 'alghemy/glyphs'
require 'alghemy/methods'

module Alghemy
  module Glyphs
    # Public: Array of commandline options for a utility.
    class Options
      extend Forwardable
      def_delegators :@list, :each, :values
      attr_reader :list

      class << self
        def build( templates, stuff = {} )
          options = new templates
          options.each do |_name, option|
            update_value stuff, option
          end
          options
        end

        def update_value( stuff, option )
          values = %i[name flag shortcut].map do |id|
            stuff[option.send(id)]
          end.compact
          option.value = values.first unless values.empty?
        end
      end

      def initialize( templates )
        @list = templates.each.with_object({}) do |(name, args), list|
          list[name] = Glyphs[:option].new(name, **args)
        end
      end

      def find( which )
        return list[which] if list.has_key?(which)
        found ||= list.values.each do |option|
          return option if option.value?(which)
        end
      end
      alias_method :[], :find
    end
  end
end
