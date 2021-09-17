require 'alghemy/ancestors'

module Alghemy
  module Rubrics
    class Cdp < Ancestors[:rubric]
      def option_templates
        stuff[:option_templates]
      end

      def invoke( io )
        previous_file = io[:output].to_s
        super unless File.exists?(previous_file)
        File.delete previous_file
        super
      end
    end
  end
end
