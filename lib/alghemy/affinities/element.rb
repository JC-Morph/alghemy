require 'alghemy/ancestors'
require 'alghemy/requests'

module Alghemy
  module Affinities
    # Public: Embodies a Raw file.
    class Element < Ancestors[:matter]
      class << self
        def defaults
          {ext: '.txt', raw_ext: '.raw'}
        end

        # Public: Hash of methods to send to self when a Transmutation expects
        # an Element of a different affinity.
        def mould
          {
            Sound: :sonify,
            Image: :sublimate,
            Video: [:visualise, {ext: 'avi'}]
          }
        end

        # Public: Colour to use when printing Affinity to the terminal.
        #
        # Returns String.
        def colour
          'forest green'
        end

        # Public: Opens Matter in the OS using a command-line program.
        def open
          Requests[:image_open]
        end
      end
    end
  end
end
