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

        # Public: Hash of methods to send to self when a Transmutation expects
        # an Element of a different affinity.
        def mould
          {
            Image: :frames,
            Sound: :sublimate,
            bmp: [:frames, {ext: 'bmp'}],
            png: [:frames, {ext: 'png'}]
          }
        end

        # Public: Colour to use when printing Affinity to the terminal.
        #
        # Returns String.
        def colour
          'medium sea green'
        end

        # Public: Opens Matter in the OS using a command-line program.
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
            /Input #\d, (image2|(bmp|png)_pipe),/
          ]
        end
      end
    end
  end
end
