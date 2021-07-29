require 'alghemy/glyphs'

module Alghemy
  module Modules
    # Public: Meta module. Defines options for commandline utilities as named
    # methods on Arrays.
    module Switcher
      attr_reader :options, :opt_hist

      # Public: Templates for options.
      def self.option_templates
        raise NotImplementedError
      end

      def build_options( lyst )
        @opt_hist = []
        @options  = Glyphs[:options].call self.class.option_templates, lyst
        def_options
      end

      # Public: Define options and their shortcuts as methods on class.
      def def_options
        switcher = singleton_class
        options.values.each do |opt|
          name = opt.name
          unless switcher.method_defined? name
            switcher.send :define_method, name do |val = nil|
              opt_hist << name
              add opt.print(val)
            end
          end
          def_aliases(switcher, opt)
        end
      end

      def def_aliases( switcher, opt )
        aliases = [opt.flag, opt.shortcut].compact
        aliases.each {|als| switcher.send(:alias_method, als, opt.name) }
      end

      # Public: Assemble pertinent memory from used options.
      def option_memory
        opt_hist.uniq.each.with_object({}) do |name, hsh|
          values = options[name].hist
          next if values.empty?
          values = values.first if values.size == 1
          hsh[name] = values unless defunct(values, name)
        end
      end

      # Public: Boolean that confirms whether an Array of values matches the
      # default values for a given option.
      #
      # Returns boolean.
      def defunct( values, name )
        values == options[name].default
      end
    end
  end
end
