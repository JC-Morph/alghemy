require 'alghemy/glyphs'

module Alghemy
  # Public: Space initialising method for Transmutations.
  module SpaceTrace
    def space_trace( cata, tree )
      return unless tree.keys.include? :size
      cata[:size] = Glyphs[:space].call(cata[:size], tree[:size])
    end
  end
end
