require 'alghemy/methods'

module Alghemy
  module Modules
    module Archives
      include Methods[:alget]

      def archive_name
        raise NotImplementedError
      end

      def archive_file
        File.join(alget(:ROOT), archive_name + '.yml')
      end

      def archive_read
        return unless File.exist?(archive_file)
        YAML.unsafe_load_file(archive_file)
      end

      def archive_write( contents )
        File.write(archive_file, YAML.dump(contents))
        contents
      end
    end
  end
end
