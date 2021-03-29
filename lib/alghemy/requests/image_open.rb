require 'alghemy/modules'

module Alghemy
  module Requests
    # Public: Display an image with imdisplay.
    module ImageOpen
      extend Modules[:request]

      def self.moniker
        ['imdisplay']
      end
    end
  end
end
