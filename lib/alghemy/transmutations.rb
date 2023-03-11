require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain transformations that can be applied
  # to data. Expected to create new files.
  module Transmutations
    extend Bandoleer

    vials = %i[amorph
               bend
               color2alpha
               compile
               convert
               fft
               frames
               giffer
               ift
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
