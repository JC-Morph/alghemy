require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    class Cdp < Ancestors[:rubric]
      def option_templates
        stuff[:option_templates]
      end
    end
  end
end
