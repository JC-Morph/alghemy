require 'alghemy/glyphs'

module Alghemy
  # Public: Space initialising method for Transmutations.
  module SpaceTrace
    def space_trace( cata, tree )
      return unless tree.keys.include? :space
      cata[:space] = Glyphs['space'].call(cata[:space], tree[:space])
    end
  end
end
