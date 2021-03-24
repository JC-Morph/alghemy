require 'alghemy/methods'
require_relative 'ladspa_info'
require_relative 'the_lads'

module Alghemy
  module Mutagens
    # Public: Represents a LADSPA plugin.
    class Ladspa
      extend  Methods[:alget]
      include LadspaInfo
      attr_reader :sijil, :automatons, :params

      class << self
        def list
          index.map {|plug| plug[/\w+(?=\.so$)/] }
        end

        def index
          index = []
          alget(:ladspath).each {|path| index << Dir.glob(File.join(path, '*.so')) }
          index.flatten
        end

        def assert( plugin )
          return plugin if plugin.is_a? self
          new plugin
        end
      end

      def initialize( plugin = nil )
        list     = self.class.list
        plugin ||= list.sample
        @sijil   = find plugin.downcase
        @name    = name
        params   = controls.merge post_fx
        @params  = params unless params.empty?
      end

      def find( plugin )
        found = LADS.select do |lad, info|
          (plugin == lad) || %i[name label id].any? do |attr|
            plugin == info[attr].downcase
          end
        end
        found ? found.keys.first : match_error
      end

      private

      def match_error
        msg = "Cannot find plugin with name: #{sijil}\nCheck [Plugin_class].list"
        raise IOError, msg
      end
    end
  end
end
