require 'alghemy/ancestors'
require 'alghemy/methods'

module Alghemy
  module Rubrics
    # Public: Define an executable process for a CDP utility.
    class Cdp < Ancestors[:rubric]
      include Methods[:alget]

      def option_templates
        stuff[:option_templates]
      end

      def invoke( io )
        previous = io[:output].to_s
        overwrite(previous) if alget(:overwrite)
        super
      end

      def overwrite( previous )
        File.delete(previous) if File.exists?(previous)
      end
    end
  end
end
