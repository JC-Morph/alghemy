require 'alghemy/modules'
require_relative 'automation'
require_relative 'param_check'
require_relative 'vst_info'

module Alghemy
  module Mutagens
    # Public: Represents a VST plugin.
    class Vst
      extend Modules[:archives]
      include ParamCheck
      include VstInfo
      attr_reader :sijil, :automatons

      class << self
        def archive_name
          '.vsts'
        end

        def list( refresh = false )
          return archive_read if archive_read && refresh != true
          name = /(?<=\\)[+\w][\w.-]+.$/
          list = index.map {|line| line[name] if line[/Vst/] }.compact
          archive_write list
        end

        def list_refresh
          list(true)
        end

        def index
          `mrswatson.exe --list-plugins 2>&1`.split
        end

        def assert( plugin )
          return plugin if plugin.is_a? self
          new plugin
        end
      end

      def initialize( plugin = nil )
        list     = self.class.list
        plugin ||= list.sample
        match    = list.map(&:downcase).include? plugin.downcase
        match_error unless match
        @sijil = plugin
      end

      def automate( stuff = {} )
        stuff = stuff.merge(total: params.size)
        @automatons = Automation.generate stuff
      end

      private

      def match_error
        msg = "Cannot find any Vsts matching: #{sijil}\nCheck Vst.list"
        raise IOError, msg
      end
    end
  end
end
