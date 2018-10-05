require 'alghemy/modules'

module Alghemy
  module Requests
    # Public: Display an image with imdisplay.
    module Display
      extend Modules[:request]

      def self.moniker
        ['imdisplay']
      end
    end
  end
end
