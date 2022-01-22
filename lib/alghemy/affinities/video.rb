require 'alghemy/ancestors'
require 'alghemy/requests'
require 'alghemy/rubrics'

module Alghemy
  module Affinities
    # Public: Represents a video.
    class Video < Ancestors[:matter]
      class << self
        def defaults
          {ext: '.avi', raw_ext: '.raw'}
        end

        def mould
          {Image: :frames, Sound: :sublimate}
        end

        def colour
          'medium sea green'
        end

        def open
          Requests[:video_open]
        end

        def analyse
          Requests[:video_info]
        end

        def rubric
          Rubrics[:ffmpeg]
        end

        def aspects
          %i[size len rate span arcana]
        end

        def tests
          [
            /valid data/,
            # %r{Duration: N/A},
            'am #\d:\d.*: Vid',
            /Input #\d, (image2|png_pipe),/
          ]
        end
      end
    end
  end
end
