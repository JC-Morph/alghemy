require 'alghemy/glyphs'
require 'alghemy/methods'

module Alghemy
  module Glyphs
    # Public: Array of commandline switches for a utility.
    class Switches < Array
      extend Methods[:array_merge]
      attr_accessor :defaults

      class << self
        def build( templates, lyst = {} )
          switches = new(templates.collect {|template| switch.new template })
          switches.defaults = {}
          switches.each do |switch|
            switches.defaults[switch.alias] = switch.default
            merge_values lyst, switch
          end
          switches
        end

        def merge_values( lyst, switch )
          s = switch
          lysted    = array_merge(lyst[s.label], lyst[s.alias])
          s.default = array_merge(lysted, s.default)
        end

        # def new_switch( template )
        #   clss = const(hsh[:type]) if hsh[:type]
        #   clss.new template
        # end

        # def const( type )
        #   type = type.capitalize.to_s + clss.to_s
        #   clss.const_get type.to_sym
        # end

        def switch
          @switch ||= Glyphs[:switch]
        end
      end

      def label( which )
        i = index {|switch| switch.send(__callee__) == which }
        slice(i)
      end
      alias alias label
    end
  end
end
