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

        def mould
          {Sound: :sublimate, Video: :compile}
        end

        def colour
          'orange red'
        end

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
