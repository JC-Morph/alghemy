require 'alghemy/modules'

module Alghemy
  module Requests
    # Public: Play sound files with sox.
    module SoundOpen
      extend Modules[:request]

      def self.moniker
        ['play']
      end
    end
  end
end
