require 'alghemy/ancestors'
require 'alghemy/requests'
require 'alghemy/rubrics'

module Alghemy
  module Affinities
    # Public: Represents a sound.
    class Sound < Ancestors[:matter]
      class << self
        def aspects
          %i[time freq lifespan depth arcana]
        end

        def defaults
          {ext: '.wav', raw_ext: '.pcm'}
        end

        def tests
          [/FAIL/]
        end

        def open
          Requests[:slay]
        end

        def analyse
          Requests[:eye]
        end

        def rubric
          Rubrics[:sock]
        end
      end
    end
  end
end
