require 'alghemy/glyphs'

module Alghemy
  module Modules
    # Public: Defines switches for commandline utilities as named methods on
    # Arrays.
    module Switcher
      attr_reader :hist, :switches

      # Public: Templates for switches.
      def self.switch_plates
        raise NotImplementedError
      end

      def build_switches( lyst )
        @hist     = []
        @switches = Glyphs[:switches].call self.class.switch_plates, lyst
        def_switches
      end

      # Public: Define switches and their aliases as methods on class.
      def def_switches
        switcher = singleton_class
        switches.each do |s|
          unless switcher.method_defined? s.label
            switcher.send :define_method, s.label do |val = nil|
              hist << s.alias
              add s.print(val)
            end
          end
          switcher.send :alias_method, s.alias, s.label
        end
      end

      # Public: Assemble pertinent memory from used switches.
      def swist
        hist.uniq.each.with_object({}) do |alas, hsh|
          swist = switches.alias(alas).hist
          next if swist.empty?
          hsh[alas] = swist unless defunct(swist, alas)
        end
      end

      # Public: Tests switch history to see if it is the same as the default
      # switch value.
      #
      # Returns boolean.
      def defunct( swist, alas )
        swist == [switches.defaults[alas]].flatten(1)
      end
    end
  end
end
