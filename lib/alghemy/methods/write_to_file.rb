require 'alghemy/methods'

module Alghemy
  module Methods
    module WriteToFile
      include Methods[:alget]

      def write_to_file( data, file )
        file = File.join(alget(:ROOT), file)
        File.open(file, 'w') do |file|
          file.puts data
        end
        file
      end
    end
  end
end
