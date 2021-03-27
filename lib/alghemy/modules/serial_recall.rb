require 'alghemy/glyphs'
require 'alghemy/methods'

module Alghemy
  module Modules
    # Public: Methods accessing stored Mems.
    module SerialRecall
      include Methods[:hshprint]
      attr_reader :mems

      def mem_init( mems )
        @mems = Glyphs[:mems].clonefreeze(mems)
      end

      def inherit(...)
        mems.recall(...)
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
