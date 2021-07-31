require 'alghemy/ancestors'
require 'alghemy/requests'
require 'alghemy/rubrics'

module Alghemy
  module Affinities
    # Public: Represents a sound.
    class Sound < Ancestors[:matter]
      class << self
        def aspects
          %i[len rate span depth arcana]
        end

        def defaults
          {ext: '.wav', raw_ext: '.pcm'}
        end

        def tests
          [/FAIL/]
        end

        def open
          Requests[:sound_open]
        end

        def analyse
          Requests[:sound_info]
        end

        def rubric
          Rubrics[:sox]
        end

        def mould
          super.merge(Image: :visualise)
        end
      end
    end
  end
end
