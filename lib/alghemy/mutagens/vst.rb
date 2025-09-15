require 'forwardable'
require 'alghemy/assistants'
require 'alghemy/modules'
require 'alghemy/requests'

module Alghemy
  module Mutagens
    # Public: Represents a VST plugin.
    class Vst
      extend Modules[:archive]
      include Assistants[:vst_info]
      attr_reader :sijil
      alias_method :to_s, :sijil

      class << self
        extend Forwardable
        delegate read_list: Requests[:vst_request]

        def list( refresh: false )
          return archive_read if archive_read && refresh != true
          archive_write read_list
        end

        def list_refresh
          list refresh: true
        end

        private

        def archive_name
          '.vsts'
        end
      end

      def initialize( plugin = nil )
        list     = self.class.list
        plugin ||= list.sample
        match    = list.map(&:downcase).include? plugin.to_s.downcase
        match_error unless match
        @sijil = plugin.to_s
      end

      private

      def match_error
        msg = "Cannot find any Vsts matching: #{sijil}\nCheck Vst.list"
        raise IOError, msg
      end
    end
  end
end
