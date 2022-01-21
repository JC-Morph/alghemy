require 'alghemy/ancestors'
require 'alghemy/methods'

module Alghemy
  module Rubrics
    class Cdp < Ancestors[:rubric]
      include Methods[:alget]

      def option_templates
        stuff[:option_templates]
      end

      def invoke( io )
        previous_file = io[:output].to_s
        if File.exists?(previous_file) && alget(:overwrite)
          File.delete previous_file
        end
        super
      end
    end
  end
end
