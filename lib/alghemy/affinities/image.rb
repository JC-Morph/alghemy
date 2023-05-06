require 'alghemy/ancestors'
require 'alghemy/requests'
require 'alghemy/rubrics'

module Alghemy
  module Affinities
    # Public: Represents an image.
    class Image < Ancestors[:matter]
      class << self
        def defaults
          {ext: '.png', raw_ext: '.rgb'}
        end

        # Public: Hash of methods to send to self when a Transmutation expects
        # an Element of a different affinity.
        def mould
          {Sound: :sublimate, Video: :compile}
        end

        # Public: Colour to use when printing Affinity to the terminal.
        #
        # Returns String.
        def colour
          'orange red'
        end

        # Public: Opens Matter in the OS using a command-line program.
        def open
          Requests[:image_open]
        end

        def analyse
          Requests[:image_info]
        end

        def rubric
          Rubrics[:magick]
        end

        def aspects
          %i[size depth arcana]
        end

        def tests
          [%r{error/.+}, %r{=>.+([./-]\w+)+\[\d+\]}, /GIF/]
        end
      end
    end
  end
end
