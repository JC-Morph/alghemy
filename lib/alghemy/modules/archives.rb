require 'yaml'
require 'alghemy/methods'

module Alghemy
  module Modules
    # Public: Wrapper functions to simplify reading and writing to yaml files.
    module Archives
      include Methods[:alget]

      def archive_file
        File.join(alget(:ROOT), archive_name + '.yml')
      end

      def archive_read
        archive = archive_file
        return unless File.exist?(archive)
        YAML.unsafe_load_file archive
      end

      def archive_write( contents )
        File.write(archive_file, YAML.dump(contents))
        contents
      end

      private

      def archive_name
        raise NotImplementedError
      end
    end
  end
end
