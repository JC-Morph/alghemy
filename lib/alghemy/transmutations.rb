require 'alghemy/bandoleer'

module Alghemy
  # Public: Bandoleer. Vials contain transformations that can be applied
  # to data. Expected to create new files.
  module Transmutations
    extend Bandoleer

    vials = %i[amorph
               bend
               bye
               concat
               congeal
               conjoin
               color2alpha
               compile
               convert
               dissolve
               ffot
               frames
               giffer
               ifot
               lad
               loop_fade
               loop_image
               loop_reverse
               mint
               mutate
               mv_average
               pixelsort
               progress_bar
               sonify
               split_rgb
               sublimate
               trim
               visualise]

    equip vials
  end
end

