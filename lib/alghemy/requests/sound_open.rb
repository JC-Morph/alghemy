require 'alghemy/modules'

module Alghemy
  module Requests
    # Public: Play sound files with sox.
    module SoundOpen
      class << self
        include Modules[:request]

        def moniker
          ['play']
        end
      end
    end
  end
end
