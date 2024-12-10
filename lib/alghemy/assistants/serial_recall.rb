require 'alghemy/glyphs'
require 'alghemy/methods'

module Alghemy
  module Assistants
    # Public: Methods accessing stored Memories.
    module SerialRecall
      include Methods[:hshprint]

      def mems
        Glyphs[:memories].call sijil
      end

      def sijil
        raise NotImplementedError
      end

      def inherit( aspect, **options )
        mems.recall aspect, options
      end

      # Public: Revert transforms on self using mems.
      def revert( with = mems, levels: nil )
        revertable = with.respond_to?(:mems) ?
          with.mems :
          with
        levels ||= revertable.size
        revertable.revert(self, levels)
      end

      # Public: Prints Mems in a human-friendly format.
      def memory
        total = mems.size
        mems.each_with_index do |mem, i|
          puts "\n\nTransform %d" % (total - i)
          hshprint mem
        end
      end
    end
  end
end
