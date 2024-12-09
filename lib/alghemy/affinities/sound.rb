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

        # Public: Hash of methods to send to self when a Transmutation expects
        # an Element of a different affinity.
        def mould
          {
            Image: :visualise,
            Video: [:visualise, {ext: 'avi'}],
            bmp:   [:visualise, {ext: 'bmp'}],
            png:   [:visualise, {ext: 'png'}]
          }
        end

        # Public: Colour to use when printing Affinity to the terminal.
        #
        # Returns String.
        def colour
          'light sky blue'
        end

        # Public: Opens Matter in the OS using a command-line program.
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
          %i[len chans rate span depth arcana]
        end

        def tests
          [/FAIL/]
        end
      end
    end
  end
end
