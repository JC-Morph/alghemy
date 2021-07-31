require 'alghemy/ancestors'
require 'alghemy/requests'
require 'alghemy/rubrics'

module Alghemy
  module Affinities
    # Public: Represents a video.
    class Video < Ancestors[:matter]
      class << self
        def aspects
          %i[size len rate span arcana]
        end

        def defaults
          {raw_ext: '.raw'}
        end

        def tests
          [
            /valid data/,
            # %r{Duration: N/A},
            'am #\d:\d.*: Vid',
            /Input #\d, (image2|png_pipe),/
          ]
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

        def mould
          {Image: :frames, Sound: :sublimate}
        end
      end
    end
  end
end
