require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    class Cdp < Ancestors[:rubric]
      def init( stuff )
        @stuff = stuff
        sub_init
        build_options(stuff[:option_templates], stuff)
        self
      end
    end
  end
end
