require 'alghemy/ancestors'
require 'alghemy/requests'
require 'alghemy/rubrics'

module Alghemy
  module Affinities
    # Public: Represents an image.
    class Image < Ancestors[:matter]
      class << self
        def aspects
          %i[size depth arcana]
        end

        def defaults
          {ext: '.png', raw_ext: '.rgb'}
        end

        def tests
          [%r{error/.+}, %r{=>.+([\./-]\w+)+\[\d+\]}, /GIF/]
        end

        def analyse
          Requests[:image_info]
        end

        def rubric
          Rubrics[:magick]
        end
      end
    end
  end
end
