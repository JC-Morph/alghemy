require 'alghemy/modules'

module Alghemy
  module Requests
    # Public: Play video files with ffplay.
    module VideoOpen
      extend Modules[:request]

      def self.moniker
        %w[ffplay -hide_banner -loglevel error -loop 0]
      end
    end
  end
end
