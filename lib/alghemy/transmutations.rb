require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain transformations that can be applied
  # to data. Expected to create new files.
  module Transmutations
    extend Bandoleer

    vials = %i[amorph
               bend
               concat
               color2alpha
               compile
               convert
               ffot
               frames
               giffer
               ifot
               lad
               loopfade
               mint
               mutate
               mv_average
               pixelsort
               sonify
               sublimate
               trim
               visualise]

    equip_constants vials
  end
end
