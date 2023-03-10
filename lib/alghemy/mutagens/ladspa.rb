require 'alghemy/data'
require 'alghemy/methods'

module Alghemy
  module Mutagens
    # Public: Represents a LADSPA plugin.
    class Ladspa
      extend Methods[:alget]
      attr_reader :sijil, :params

      class << self
        def dict
          Data[:ladspa]
        end

        def list
          present = index.map {|plug| plug[/\w+(?=\.so$)/] }
          present & dict.keys
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

      def dict
        self.class.dict
      end

      def initialize( plugin = nil )
        plugin ||= self.class.list.sample
        @sijil = find plugin
        @name  = name
        params  = controls.merge(post_fx)
        @params = params unless params.empty?
      end

      def find( plugin )
        plug = plugin.to_s.downcase
        found = dict.select do |lad, info|
          (plug == lad) || %i[label id].any? do |attr|
            plug == info[attr].downcase
          end
        end
        found ? found.keys.first : match_error
      end

      def name
        dict[sijil][__callee__]
      end
      %i[label id audio].each do |attr|
        alias_method attr, :name
      end

      def controls
        dict[sijil][__callee__] || {}
      end
      alias_method :post_fx, :controls

      private

      def match_error
        msg  = %{Cannot find any plugins matching: #{sijil}
          Check [Plugin_class].list}
        raise IOError, msg
      end
    end
  end
end
