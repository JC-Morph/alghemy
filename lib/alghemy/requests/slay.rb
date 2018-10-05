require 'alghemy/modules'

module Alghemy
  module Requests
    # Public: Play sound files with sox.
    module Slay
      class << self
        include Modules[:request]

        def moniker
          ['sox']
        end

        def sub_process
          input << wave_type
        end

        def wave_type
          %w[-t waveaudio]
        end
      end
    end
  end
end
