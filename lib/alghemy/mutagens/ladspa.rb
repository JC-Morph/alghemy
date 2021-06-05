require 'alghemy/methods'
require_relative 'ladspa_info'

module Alghemy
  module Mutagens
    # Public: Represents a LADSPA plugin.
    class Ladspa
      extend  Methods[:alget]
      include LadspaInfo
      attr_reader :sijil, :params

      class << self
        def list
          index.map {|plug| plug[/\w+(?=\.so$)/] }
        end

        def index
          alget(:ladspath).each.with_object([]) do |path, index|
            index << Dir.glob(File.join(path, '*.so'))
          end.flatten
        end

        def assert( plugin )
          return plugin if plugin.is_a? self
          new plugin
        end
      end

      def initialize( plugin = nil )
        list     = self.class.list
        plugin ||= list.sample
        @sijil   = find plugin
        @name    = name
        params   = controls.merge post_fx
        @params  = params unless params.empty?
      end

      def find( plugin )
        plug = plugin.downcase
        found = LADS.select do |lad, info|
          (plug == lad) || %i[label id].any? do |attr|
            plug == info[attr].downcase
          end
        end
        found ? found.keys.first : match_error
      end

      private

      def match_error
        msg = "Can't find plugin with name: #{sijil}\nCheck [Plugin_class].list"
        raise IOError, msg
      end
    end
  end
end
