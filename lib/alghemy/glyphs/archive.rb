require 'yaml'
require 'alghemy/methods'

module Alghemy
  module Glyphs
    module Archive
      class << self
        include Methods[:alget]
        attr_reader :contents, :pwd

        def read
          return unless File.exist?(archive)
          @contents = YAML.unsafe_load_file(archive)
          @pwd      = Dir.pwd
        end

        def store( sijil, new_content )
          return if new_content.empty?
          read unless contents && pwd == Dir.pwd
          @contents ||= {}
          contents[sijil.to_s] = new_content
          File.write(archive, YAML.dump(contents))
        end

        private

        def archive
          File.join(alget(:ROOT), '.archive.yml')
        end
      end
    end
  end
end
