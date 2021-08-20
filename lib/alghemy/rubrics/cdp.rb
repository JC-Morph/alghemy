require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    class Cdp < Ancestors[:rubric]
      def option_templates
        stuff[:option_templates]
      end

      def invoke( io )
        File.delete io[:output].to_s
        super
      end
    end
  end
end
