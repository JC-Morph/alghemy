require 'alghemy/ancestors'
require 'alghemy/requests'
require 'alghemy/rubrics'

module Alghemy
  module Affinities
    # Public: Represents a sound.
    class Sound < Ancestors[:matter]
      class << self
        def defaults
          {ext: '.wav', raw_ext: '.pcm'}
        end

        def mould
          {Image: :visualise, Video: [:visualise, {ext: 'avi'}]}
        end

        def colour
          'light sky blue'
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

        def aspects
          %i[len rate span depth arcana]
        end

        def tests
          [/FAIL/]
        end
      end
    end
  end
end
