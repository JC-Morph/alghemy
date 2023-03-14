require 'yaml'
require 'alghemy/methods'

module Alghemy
  module Glyphs
    # Public: Manages reading and writing to yaml files. Used to store Memories
    # of Transmutations on Matter, allowing for the reversion of Matter to
    # previous states.
    module Archive
      class << self
        include Methods[:alget]
        attr_reader :contents, :directory

        def read
          return unless File.exist?(archive)
          @contents  = YAML.unsafe_load_file(archive)
          dir        = File.dirname(archive)
          @directory = dir == '.' ? Dir.pwd : dir
        end

        def store( sijil, new_content )
          return if new_content.empty?
          read unless contents && directory == Dir.pwd
          @contents ||= {}
          contents[sijil.to_s] = new_content
          File.write(archive, YAML.dump(contents))
        end

        def retrieve( sijil )
          read unless contents && directory == Dir.pwd
          entries = []
          sijil   = sijil.to_s
          while contents[sijil]
            entry = contents[sijil]
            entries << entry
            sijil = entry[:list].sijil.to_s
          end
          entries.reverse
        end

        def select( &block )
          read
          contents.select(&block)
        end

        private

        def archive
          File.join(alget(:ROOT), '.archive.yml')
        end
      end
    end
  end
end
