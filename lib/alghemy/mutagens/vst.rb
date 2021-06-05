require_relative 'automation'
require_relative 'param_check'
require_relative 'vst_info'

module Alghemy
  module Mutagens
    # Public: Represents a VST plugin.
    class Vst
      include VstInfo
      include ParamCheck
      attr_reader :sijil, :automatons

      def self.list
        name = /(?<=\\)[+\w][\w\.-]+.$/
        index.map {|line| line[name] if line[/Vst/] }.compact
      end

      def self.index
        `mrswatson --list-plugins 2>&1`.split
      end

      def self.assert( plugin )
        return plugin if plugin.is_a? self
        new plugin
      end

      def initialize( plugin = nil )
        list     = self.class.list
        plugin ||= list.sample
        match    = list.map(&:downcase).include? plugin.downcase
        match_error unless match
        @sijil = plugin
      end

      def automate( lyst = {} )
        lyst = lyst.merge(total: params.size)
        @automatons = Automation.generate lyst
      end

      private

      def match_error
        msg = "Cannot find Vst with name: #{sijil}\nCheck Vst.list"
        raise IOError, msg
      end
    end
  end
end
