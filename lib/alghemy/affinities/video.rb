require 'alghemy/ancestors'
require 'alghemy/requests'
require 'alghemy/rubrics'

module Alghemy
  module Affinities
    # Public: Represents a video.
    class Video < Ancestors[:matter]
      class << self
        def aspects
          %i[space time freq lifespan arcana]
        end

        def defaults
          {raw_ext: '.raw'}
        end

        def tests
          [
            /valid data/,
            %r{ration: N/A},
            'am #\d:\d.*: Vid',
            /Input #\d, image2,/
          ]
        end

        def open
          Requests[:flay]
        end

        def analyse
          Requests[:probe]
        end

        def rubric
          Rubrics[:fock]
        end
      end
    end
  end
end
