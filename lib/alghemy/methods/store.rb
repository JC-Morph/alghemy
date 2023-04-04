require 'alghemy/glyphs'

module Alghemy
  module Methods
    # Public: Memory recording module.
    module Store
      # Public: Stores an entry in the archive as a Memory.
      #
      # entry - Hash of options from a transform.
      def store( entry )
        memory = Glyphs[:memory].new(entry)
        Glyphs[:archive].store(to_s, memory)
      end
    end
  end
end
