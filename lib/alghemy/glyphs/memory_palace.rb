require 'alghemy/modules'

module Alghemy
  module Glyphs
    # Public: Used to store Memories of Transmutations on Matter,
    # allowing for the reversion of Matter to previous states.
    module MemoryPalace
      class << self
        include Modules[:archive]
        attr_reader :palace_map, :palace_location

        def open_palace_map
          @palace_map = archive_read || {}
          dir = File.dirname(archive_file)
          @palace_location = dir == '.' ? Dir.pwd : dir
        end

        def add_memory( sijil, new_room )
          return if new_room.empty?
          check_map_is_open
          @palace_map ||= {}
          palace_map[sijil.to_s] = new_room
          archive_write palace_map
        end

        def follow_memory( sijil )
          check_map_is_open
          memories = []
          sijil = sijil.to_s
          while palace_map[sijil]
            memory = palace_map[sijil]
            memories << memory
            sijil = memory[:list].sijil.to_s
          end
          memories.reverse
        end

        def select_memories( &block )
          check_map_is_open
          palace_map.select(&block)
        end

        private

        def archive_name
          '.memory_palace'
        end

        def check_map_is_open
          open_palace_map unless palace_map && palace_location == Dir.pwd
        end
      end
    end
  end
end
