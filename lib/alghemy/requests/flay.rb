require 'alghemy/modules'

module Alghemy
  module Requests
    # Public: Play video files with ffplay.
    module Flay
      extend Modules[:request]

      def self.moniker
        %w[ffplay -hide_banner]
      end
    end
  end
end
