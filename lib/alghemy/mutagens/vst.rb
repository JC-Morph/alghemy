require 'alghemy/assistants'
require 'alghemy/comrades'
require 'alghemy/methods'
require 'alghemy/modules'
require_relative 'automation'

module Alghemy
  module Mutagens
    # Public: Represents a VST plugin.
    class Vst
      extend Modules[:archives]
      include Assistants[:vst_info]
      include Methods[:alget]
      attr_reader :sijil, :automatons
      alias_method :to_s, :sijil

      class << self
        def list( refresh: false )
          return archive_read if archive_read && refresh != true
          archive_write format_list
        end

        def list_refresh
          list refresh: true
        end

        private

        def archive_name
          '.vsts'
        end

        def format_list
          write_list
          File.read(tmp_name).split.map do |line|
            line[/(?<=\\)[+\w][\w.-]+.$/] if line[/Vst/]
          end.compact
        end

        def write_list
          FileUtils.makedirs alget(:ROOT)
          spell = "mrswatson.exe --list-plugins 2> #{tmp_name}"
          Comrads[:invoker].cast spell
        end

        def tmp_name
          File.join(alget(:ROOT), '.vst_info')
        end
      end

      def initialize( plugin = nil )
        list     = self.class.list
        plugin ||= list.sample
        match    = list.map(&:downcase).include? plugin.downcase
        match_error unless match
        @sijil = plugin.to_s
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
