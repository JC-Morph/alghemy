require 'alghemy/modules'

module Alghemy
  module Glyphs
    # Public: Used to store Memories of Transmutations on Matter,
    # allowing for the reversion of Matter to previous states.
    module Archive
      class << self
        include Modules[:archives]
        attr_reader :contents, :directory

        def read
          @contents  = archive_read
          dir        = File.dirname(archive_file)
          @directory = dir == '.' ? Dir.pwd : dir
        end

        def store( sijil, new_content )
          return if new_content.empty?
          update_state
          @contents ||= {}
          contents[sijil.to_s] = new_content
          archive_write contents
        end

        def retrieve( sijil )
          update_state
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

        def archive_name
          '.archive'
        end

        def update_state
          read unless contents && directory == Dir.pwd
        end
      end
    end
  end
end
