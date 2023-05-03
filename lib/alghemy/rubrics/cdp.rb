require 'alghemy/ancestors'
require 'alghemy/methods'

module Alghemy
  module Rubrics
    # Public: Define an executable process for a CDP utility.
    class Cdp < Ancestors[:rubric]
      include Methods[:alget]

      # Public: Templates used to create an Options object for handling
      # commandline flags and their arguments.
      def option_templates
        stuff[:option_templates]
      end

      # Public: Executes process with input and output provided.
      # Creates a new file.
      #
      # io - Hash of filenames to use in process:
      #      :input  - String naming input file(s). Files should exist.
      #      :output - String naming output file(s). Files can exist.
      def invoke( io )
        previous = io[:output].to_s
        overwrite(previous) if alget(:overwrite)
        super
      end

      # Public: Delete a file to allow writing to filename again.
      # CDP processes exit with an error if the filename already exists.
      #
      # previous - Filename to delete.
      def overwrite( previous )
        File.delete(previous) if File.exists?(previous)
      end
    end
  end
end
