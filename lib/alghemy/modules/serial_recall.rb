require 'alghemy/glyphs'
require 'alghemy/methods'

module Alghemy
  module Modules
    # Public: Methods accessing stored Memories.
    module SerialRecall
      include Methods[:hshprint]
      attr_reader :mems

      def mem_init( mems )
        @mems = Glyphs[:memories].clonefreeze(mems)
      end

      def inherit( aspect, **options )
        mems.recall(aspect, options) || {}
      end

      # Public: Revert transforms on self using Mems.
      def revert( levels = mems.size )
        mems.revert(self, levels)
      end

      # Public: Prints Mems in a human-friendly format.
      def memory
        mems.each.with_index do |mem, i|
          asps = {method: mem[0]}.merge mem[1]
          puts "\n\nTransform #{mems.size - i}"
          hshprint asps
        end
      end
    end
  end
end
